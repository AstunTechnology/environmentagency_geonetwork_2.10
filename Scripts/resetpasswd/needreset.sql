SELECT *
FROM public.users
WHERE id NOT IN (
    SELECT DISTINCT (row_data->'id')::int AS userid
    FROM audit.logged_actions
    WHERE SCHEMA_NAME = 'public'
        AND TABLE_NAME = 'users'
        AND action_tstamp_tx > CURRENT_TIMESTAMP - INTERVAL '%(num_days)s' DAY
        AND ((action = 'U' AND changed_fields ? 'password') OR action = 'I')
    ORDER BY userid
) ORDER BY id;
