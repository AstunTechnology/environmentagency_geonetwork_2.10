<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!--    Transformation to try and fix records so they have the correct schemalocation-->

<xsl:stylesheet version="1.0" exclude-result-prefixes="eamp" xmlns:geonet="http://www.fao.org/geonetwork" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eamp="http://environment.data.gov.uk/eamp" xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">


        <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>



        <!-- copy All -->
        <xsl:template match="@* | node()">
                <xsl:copy>
                        <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
        </xsl:template>

        <!-- Remove geonet:* elements. -->
    <xsl:template match="geonet:*" priority="2"/>

        <!-- Fix status -->
    <xsl:template match="*/eamp:EA_AfaStatus">
        <xsl:if test="contains(.,'AfA (Publication Scheme &amp; Information for Re-Use Register)')">
        <xsl:message>==== Dodgy status ====</xsl:message>
                <eamp:EA_AfaStatus>AfA (Publication Scheme and Information for Re-Use Register)</eamp:EA_AfaStatus>
        </xsl:if>
        <xsl:if test="not(contains(.,'AfA (Publication Scheme &amp; Information for Re-Use Register)'))">
        <xsl:message>==== OK status ====</xsl:message>
        <xsl:apply-templates select="@* | node()"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>

<!--<eamp:EA_Constraints>
<eamp:afa>
<eamp:EA_Afa>
<eamp:afaNumber>
<gco:Decimal>307</gco:Decimal>
</eamp:afaNumber>
<eamp:afaStatus>
<eamp:EA_AfaStatus>AfA (Publication Scheme and Information for Re-Use Register)</eamp:EA_AfaStatus>
</eamp:afaStatus>
</eamp:EA_Afa>
</eamp:afa>
</eamp:EA_Constraints> -->