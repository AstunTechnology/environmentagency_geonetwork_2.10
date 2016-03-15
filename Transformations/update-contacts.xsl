<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!-- Transformation script to update contact information-->

<xsl:stylesheet version="1.0" exclude-result-prefixes="#all" xmlns:geonet="http://www.fao.org/geonetwork" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eamp="http://environment.data.gov.uk/eamp" xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

    <xsl:param name="oldEmail" select="''"/>
    <xsl:param name="newName" select="''"/>
    <xsl:param name="newEmail" select="''"/>
    <xsl:param name="newOrg" select="'Environment Agency'"/>
    <xsl:param name="newPos" select="''"/>
    <xsl:param name="newRole" select="'custodian'"/>
    
   
    <xsl:template match="*/gmd:pointOfContact">
        <gmd:pointOfContact>
            <xsl:variable name="email">
            <xsl:value-of select="translate(./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString, $uppercase, $lowercase)"/>
            </xsl:variable>
            <xsl:if test="contains($email,$oldEmail)">
                <gmd:CI_ResponsibleParty>
                    <gmd:individualName>
                        <gco:CharacterString><xsl:value-of select="$newName"/></gco:CharacterString>
                    </gmd:individualName>
                    <gmd:organisationName>
                        <gco:CharacterString><xsl:value-of select="$newOrg"/></gco:CharacterString>
                    </gmd:organisationName>
                    <gmd:positionName>
                        <gco:CharacterString><xsl:value-of select="$newPos"/></gco:CharacterString>
                    </gmd:positionName>
                    <gmd:contactInfo>
                        <gmd:CI_Contact>
                            <gmd:address>
                                <gmd:CI_Address>
                                    <gmd:electronicMailAddress>
                                        <gco:CharacterString><xsl:value-of select="$newEmail"/></gco:CharacterString>
                                    </gmd:electronicMailAddress>
                                </gmd:CI_Address>
                            </gmd:address>
                        </gmd:CI_Contact>
                    </gmd:contactInfo>
                    <gmd:role>
                        <gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="{$newRole}"/>
                    </gmd:role>
                </gmd:CI_ResponsibleParty>
            </xsl:if>
            <xsl:if test="not(contains($email,$oldEmail))">
                <xsl:apply-templates select="@* | node()"/>
            </xsl:if>
        </gmd:pointOfContact>
    </xsl:template>
    
    <!-- Copy All -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>

    <!-- Remove geonet:* elements. -->
    <xsl:template match="geonet:*" priority="2"/>

</xsl:stylesheet>