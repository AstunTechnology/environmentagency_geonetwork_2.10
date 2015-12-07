<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="#all">



<!-- Update identifier with metadata file identifier but don't overwrite existing codes prefixed 'DSTR' -->

<xsl:template match="gmd:identificationInfo/*/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code" >
    <xsl:variable name="code">
        <xsl:value-of select="./gco:CharacterString"/>
    </xsl:variable>

    <xsl:variable name="id" select="/*/gmd:fileIdentifier/gco:CharacterString"/>


  <xsl:if test="not(starts-with($code,'DSTR'))">
        <xsl:message>==== Add missing resource identifier ====</xsl:message>
        <gmd:code>
            <gco:CharacterString><xsl:value-of select="$id"/></gco:CharacterString>
        </gmd:code>
    </xsl:if>
    <xsl:if test="starts-with($code,'DSTR')">
        <xsl:message>=== Skipping existing DSTR code=== </xsl:message>
        <gmd:code>
            <xsl:apply-templates select="@* | node()"/>
        </gmd:code>
    </xsl:if>
</xsl:template>

<!-- copy All -->
<xsl:template match="@* | node()">
        <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
</xsl:template>

</xsl:stylesheet>

