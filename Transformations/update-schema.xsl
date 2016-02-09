<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!--	Force metadata to have Gemini 2.2 Metadata Standard and Version
-->

<xsl:stylesheet version="1.0" exclude-result-prefixes="#all" xmlns:geonet="http://www.fao.org/geonetwork" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eamp="http://environment.data.gov.uk/eamp" xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

	
	<!-- Change standard from EAMP to Gemini -->
	<xsl:template match="*/gmd:metadataStandardName">
		<xsl:message>==== Updating Metadata Standard Name ====</xsl:message>
		<gmd:metadataStandardName>
			<gco:CharacterString>Gemini</gco:CharacterString>
		</gmd:metadataStandardName>
	</xsl:template>
	<xsl:template match="*/gmd:metadataStandardVersion">
		<gmd:metadataStandardVersion>
			<gco:CharacterString>2.2</gco:CharacterString>
		</gmd:metadataStandardVersion>
	</xsl:template>

		<!-- Change EAMP schema location to gemini version -->
	<xsl:template match="/*">
		<xsl:element name="{name()}" namespace="{namespace-uri()}">
			<xsl:copy-of select="namespace::*[name()]"/>
			<xsl:apply-templates select="@*"/>
				<xsl:attribute name="xsi:schemaLocation">
					<xsl:value-of select="'http://www.isotc211.org/2005/gmx http://eden.ign.fr/xsd/isotc211/isofull/20090316/gmx/gmx.xsd'"/>
				</xsl:attribute>
			<xsl:apply-templates select="node()"/>
		</xsl:element>
	</xsl:template>	
	
	<!-- copy All -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- Remove geonet:* elements. -->
    <xsl:template match="geonet:*" priority="2"/>
	
</xsl:stylesheet>
