-- View: all_records_defra

-- DROP VIEW all_records_defra;

CREATE OR REPLACE VIEW all_records_defra AS 
 SELECT ('"'::text || bah.id) || '"'::text AS id,
    ('"'::text || bah.uuid::text) || '"'::text AS uuid,
    ('"'::text || array_to_string(xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]), '-'::text)) || '"'::text AS title,
    ('"'::text || statusvalues.name::text) || '"'::text AS status,
    regexp_replace(('"'::text || array_to_string(xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]), '-'::text)) || '"'::text, '[\n\r\u2028]+'::text, ' '::text, 'g'::text) AS abstract,
    ('"'::text || array_to_string(xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]), '|'::text)) || '"'::text AS keywords,
    ('"'::text || array_to_string(xpath('/gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource/gmd:linkage/gmd:URL/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]), '|'::text)) || '"'::text AS orl,
    regexp_replace(('"'::text || array_to_string(xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]), '|'::text)) || '"'::text, '[\n\r\u2028]+'::text, ' '::text, 'g'::text) AS otherconstraints,
    (('"'::text || (((((((COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[1]::text, ''::text) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[1]::text, ''::text)) || ' '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:positionName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[1]::text, ''::text)) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[1]::text, ''::text)) || ' | '::text)) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[1]::text, ''::text)) || '"'::text AS contact1,
    (('"'::text || (((((((COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[2]::text, ''::text) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[2]::text, ''::text)) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:positionName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[2]::text, ''::text)) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[2]::text, ''::text)) || ' | '::text)) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[2]::text, ''::text)) || '"'::text AS contact2,
    (('"'::text || (((((((COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[3]::text, ''::text) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[3]::text, ''::text)) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:positionName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[3]::text, ''::text)) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[3]::text, ''::text)) || ' | '::text)) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[1]::text, ''::text)) || '"'::text AS contact3,
    (('"'::text || (((((((COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[4]::text, ''::text) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[4]::text, ''::text)) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:positionName/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[4]::text, ''::text)) || ' | '::text) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[4]::text, ''::text)) || ' '::text)) || COALESCE((xpath('/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/text()'::text, bah.data_xml, '{{gco,http://www.isotc211.org/2005/gco},{gmd,http://www.isotc211.org/2005/gmd}}'::text[]))[1]::text, ''::text)) || '"'::text AS contact4,
    ('"'::text || categories.name::text) || '"'::text
   FROM ( SELECT DISTINCT ON (metadatastatus.metadataid) metadatastatus.metadataid,
            metadatastatus.statusid,
            metadatastatus.userid,
            metadatastatus.changedate,
            metadatastatus.changemessage
           FROM metadatastatus
          ORDER BY metadatastatus.metadataid, metadatastatus.changedate DESC) foo
     LEFT JOIN statusvalues ON foo.statusid = statusvalues.id
     LEFT JOIN ( SELECT metadata_xml.id,
            metadata_xml.uuid,
            metadata_xml.schemaid,
            metadata_xml.istemplate,
            metadata_xml.isharvested,
            metadata_xml.createdate,
            metadata_xml.changedate,
            metadata_xml.data_xml,
            metadata_xml.data,
            metadata_xml.source,
            metadata_xml.title,
            metadata_xml.root,
            metadata_xml.harvestuuid,
            metadata_xml.owner,
            metadata_xml.doctype,
            metadata_xml.groupowner,
            metadata_xml.harvesturi,
            metadata_xml.rating,
            metadata_xml.popularity,
            metadata_xml.displayorder
           FROM metadata_xml
          WHERE metadata_xml.istemplate <> 'y'::bpchar
          ORDER BY metadata_xml.id) bah ON foo.metadataid = bah.id
     LEFT JOIN metadatacateg ON bah.id = metadatacateg.metadataid
     LEFT JOIN categories ON metadatacateg.categoryid = categories.id
  ORDER BY categories.name, bah.id;

ALTER TABLE all_records_defra
  OWNER TO defra_geonetwork;

