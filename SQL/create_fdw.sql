--create extension postgres_fdw;

--drop server ea_pub_csw cascade;

create server ea_pub_csw
foreign data wrapper postgres_fdw
options (dbname 'ea_geonetwork_public_live', host 'localhost');

create user mapping for geonetwork
server ea_pub_csw
options(user 'redacted', password 'redacted');

create foreign table pub_metadata
(id integer NOT NULL,
  uuid character varying(250) NOT NULL,
  schemaid character varying(32) NOT NULL,
  istemplate character(1) NOT NULL DEFAULT 'n'::bpchar,
  isharvested character(1) NOT NULL DEFAULT 'n'::bpchar,
  createdate character varying(30) NOT NULL,
  changedate character varying(30) NOT NULL,
  data text NOT NULL,
  source character varying(250) NOT NULL,
  title character varying(255),
  root character varying(255),
  harvestuuid character varying(250) DEFAULT NULL::character varying,
  owner integer NOT NULL,
  doctype character varying(255),
  groupowner integer,
  harvesturi character varying(512) DEFAULT NULL::character varying,
  rating integer NOT NULL DEFAULT 0,
  popularity integer NOT NULL DEFAULT 0,
  displayorder integer)
  server ea_pub_csw options (table_name 'metadata');


