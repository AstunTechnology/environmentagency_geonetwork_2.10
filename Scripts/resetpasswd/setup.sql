-- Ensure the GeoNetwork users table is audited
SELECT audit.audit_table('public.users');

-- Helper function to determine if a password value is reset
CREATE OR REPLACE FUNCTION password_is_reset(text) RETURNS boolean AS $$
    -- A reset password is either 80 'a's or 'b's
    SELECT ($1 ~ '^(a|b)\1{79,}$') AS result;
$$ LANGUAGE SQL;

-- Define a trigger to ensure a user has the highest profile assigned when they
-- change their password from the default reset password

CREATE OR REPLACE FUNCTION public.users_password_change_update_profile() RETURNS TRIGGER AS $function$
BEGIN
IF password_is_reset(OLD.password) AND NOT password_is_reset(NEW.password) THEN
    NEW.profile := (SELECT profile
                    FROM
                        (SELECT event_id,
                            row_data,
                            changed_fields,
                            CASE
                                WHEN changed_fields ? 'password' AND password_is_reset(changed_fields->'password') THEN
                                    row_data->'profile'
                                WHEN changed_fields ? 'profile' THEN
                                    changed_fields->'profile'
                                ELSE
                                    row_data->'profile'
                            END AS profile
                        FROM audit.logged_actions
                        WHERE SCHEMA_NAME = 'public'
                            AND TABLE_NAME = 'users'
                            AND (row_data->'id')::int = NEW.id
                            AND NOT (password_is_reset(row_data->'password') AND NOT changed_fields ? 'profile')
                            AND NOT (password_is_reset(row_data->'password') AND password_is_reset(changed_fields->'password'))
                        ORDER BY event_id desc) AS a LIMIT 1);
END IF;
RETURN NEW;
END;
$function$ LANGUAGE plpgsql;
COMMENT ON FUNCTION public.users_password_change_update_profile() IS $comment$
Trigger function to ensure that if a users password is being changed from the
default reset password then ensure the users profile is restored to it's
correct value
$comment$;

DROP TRIGGER IF EXISTS users_password_change ON users;
CREATE TRIGGER users_password_change
BEFORE UPDATE OF password ON public.users
FOR EACH ROW
EXECUTE PROCEDURE public.users_password_change_update_profile();
