UPDATE public.users
SET
    profile = 'RegisteredUser',
    password = CASE WHEN (password = rpad('', 80, 'b')) THEN rpad('', 80, 'a') ELSE rpad('', 80, 'b') END
WHERE id = %(id)s;
