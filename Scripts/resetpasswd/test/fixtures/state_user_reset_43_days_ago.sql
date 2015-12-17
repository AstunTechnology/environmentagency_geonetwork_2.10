TRUNCATE users;

INSERT INTO users (id, username, password, surname, name, profile, address, city, state, zip, country, email, organisation, kind, security, authtype) VALUES (1, 'admin', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'admin', 'admin', 'RegisteredUser', NULL, NULL, NULL, NULL, NULL, 'admin@example.com', NULL, 'gov', NULL, NULL);

TRUNCATE audit.logged_actions;

INSERT INTO audit.logged_actions (event_id, schema_name, table_name, relid, session_user_name, action_tstamp_tx, action_tstamp_stm, action_tstamp_clk, transaction_id, application_name, client_addr, client_port, client_query, action, row_data, changed_fields, statement_only) VALUES (4, 'public', 'users', 1625480, 'resetpasswd', current_timestamp - interval '43 days', current_timestamp - interval '43 days', current_timestamp - interval '43 days', 35483887, '', '127.0.0.1', 59180, '--sql--', 'U', '"id"=>"1", "zip"=>NULL, "city"=>NULL, "kind"=>"gov", "name"=>"admin", "email"=>"admin@example.com", "state"=>NULL, "address"=>NULL, "country"=>NULL, "profile"=>"Administrator", "surname"=>"admin", "authtype"=>NULL, "password"=>"aba4c2c985d446a6c901ff0447fc9dbfc8cfff9cdac0ae065c93238de15562a6f5dfa9f7c031d4ed", "security"=>NULL, "username"=>"admin", "organisation"=>NULL', '"profile"=>"RegisteredUser", "password"=>"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"', false);
