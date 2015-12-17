SELECT *
FROM public.users
WHERE id IN (
    SELECT DISTINCT (row_data->'id')::int AS userid
    FROM audit.logged_actions
    WHERE SCHEMA_NAME = 'public'
        AND TABLE_NAME = 'users'
        AND extract(day from current_timestamp - action_tstamp_tx) = %(num_days)s - %(reminder_days)s
        AND ((action = 'U' AND changed_fields ? 'password') OR action = 'I')
    ORDER BY userid
) AND NOT password_is_reset(password) ORDER BY id;
