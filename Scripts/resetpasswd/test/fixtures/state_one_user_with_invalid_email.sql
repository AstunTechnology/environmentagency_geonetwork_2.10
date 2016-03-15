TRUNCATE users;

INSERT INTO users VALUES (1,'admin','aba4c2c985d446a6c901ff0447fc9dbfc8cfff9cdac0ae065c93238de15562a6f5dfa9f7c031d4ed','admin','admin','Administrator',null,null,null,null,null,'invalid-email',null,'gov',null,null);
INSERT INTO users VALUES (3,'ella','aba4c2c985d446a6c901ff0447fc9dbfc8cfff9cdac0ae065c93238de15562a6f5dfa9f7c031d4ed','Easton','Ella','Reviewer',null,null,null,null,null,'ella@example.com',null,'gov',null,null);
INSERT INTO users VALUES (4,'cody','d7168ec2e6d274e517bc3ee8585d81d5b782d0c66e97a4b2f5a74b85dd6266018cebe27ace2ae78f','Davis','Cody','Editor',null,null,null,null,null,'cody@example.com',null,'gov',null,null);

-- No data in audit.logged_actions
TRUNCATE audit.logged_actions;

