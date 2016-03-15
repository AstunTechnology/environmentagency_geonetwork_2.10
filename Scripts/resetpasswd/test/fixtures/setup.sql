-- Settings

DROP TABLE IF EXISTS settings;
CREATE TABLE settings (
    id integer NOT NULL,
    parentid integer,
    name character varying(64) NOT NULL,
    value text
);

INSERT INTO settings VALUES (0,null,'root',null);
INSERT INTO settings VALUES (1,0,'system',null);
INSERT INTO settings VALUES (10,1,'site',null);
INSERT INTO settings VALUES (11,10,'name','Metadata Catalogue');
INSERT INTO settings VALUES (13,10,'organization','Environment Agency');
INSERT INTO settings VALUES (20,1,'server',null);
INSERT INTO settings VALUES (21,20,'host','example.com');
INSERT INTO settings VALUES (22,20,'port',80);
INSERT INTO settings VALUES (23,20,'protocol','http');
INSERT INTO settings VALUES (30,1,'feedback',null);
INSERT INTO settings VALUES (31,30,'email','bob@example.com');
INSERT INTO settings VALUES (32,30,'mailServer',null);
INSERT INTO settings VALUES (33,32,'host','mail.example.com');
INSERT INTO settings VALUES (34,32,'port',21);

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_parentid_fkey FOREIGN KEY (parentid) REFERENCES settings(id);

-- Users

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id integer NOT NULL,
    username character varying(256) NOT NULL,
    password character varying(120) NOT NULL,
    surname character varying(32),
    name character varying(32),
    profile character varying(32) NOT NULL,
    address character varying(128),
    city character varying(128),
    state character varying(32),
    zip character varying(16),
    country character varying(128),
    email character varying(128),
    organisation character varying(128),
    kind character varying(16),
    security character varying(128) DEFAULT ''::character varying,
    authtype character varying(32)
);

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);
