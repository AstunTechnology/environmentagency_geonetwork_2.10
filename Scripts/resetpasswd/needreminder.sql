-- All events from the audit table where a user was inserted or their password
-- changed
WITH all_password_events AS
    (SELECT (row_data->'id')::int AS userid,
            *
     FROM audit.logged_actions
     WHERE SCHEMA_NAME = 'public'
         AND TABLE_NAME = 'users'
         AND ((action = 'U'
               AND changed_fields ? 'password')
              OR action = 'I')),
-- Only the latest password event for each user
latest_password_event_per_user AS
    (SELECT DISTINCT ON (userid) *
     FROM all_password_events
     ORDER BY userid,
              action_tstamp_tx DESC),
-- The latest password event for each user which occured reset_days minus
-- reminder_days ago and are hence potential candidates for a reminder
reminder_latest_password_event_per_user AS
    (SELECT *
     FROM latest_password_event_per_user
     WHERE extract(DAY FROM CURRENT_TIMESTAMP - action_tstamp_tx) = %(num_days)s - %(reminder_days)s)
-- Users who are not currently reset and require a reminder
SELECT *
FROM public.users
WHERE id IN
        (SELECT DISTINCT userid
         FROM reminder_latest_password_event_per_user)
    AND NOT password_is_reset(password)
ORDER BY id;
