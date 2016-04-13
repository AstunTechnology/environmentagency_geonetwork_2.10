<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!--	Trasformation for EAMP extended metadata to data.go.uk, anonymizing and removing information on the way out of GeoNetwork.
	Some information has been swapped around so that it displays more pertinently on the data.gov.uk website, as the headings of
	the elements on the display page are not Gemini compliant and a bit muddled.
	Author:		Environment Agency
	Date:		2015 02 20
	Version:	1
-->

<xsl:stylesheet version="1.0" exclude-result-prefixes="eamp" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:eamp="http://environment.data.gov.uk/eamp" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
	
	<!-- Find out which organisation we're working with -->
	<xsl:variable name="email">
		<xsl:value-of select="/gmd:MD_Metadata/gmd:contact[1]/gmd:CI_ResponsibleParty[1]/gmd:contactInfo[1]/gmd:CI_Contact[1]/gmd:address[1]/gmd:CI_Address[1]/gmd:electronicMailAddress[1]/gco:CharacterString[1]"/>
	</xsl:variable>
	
	
	
	<!-- Add any nodes here that are not to be copied over. Separate with '|', a pipe. If node is a parent, children will not be copied either. -->
	<xsl:template match="gmd:pointOfContact"/>
	
	<!-- Remove AfA element and switch around some info specific to data.gov.uk as requested by CJ, MG and WT -->
	<xsl:template match="*/gmd:resourceConstraints">
		<xsl:if test="not(./eamp:EA_Constraints)">
			<xsl:for-each select="./gmd:MD_LegalConstraints/gmd:otherConstraints/gco:CharacterString">
				<xsl:if test="contains(.,'Data will be licensed')">
					<gmd:resourceConstraints>
						<gmd:MD_Constraints>
							<gmd:useLimitation>
								<gco:CharacterString><xsl:value-of select="."></xsl:value-of></gco:CharacterString>
							</gmd:useLimitation>
						</gmd:MD_Constraints>
					</gmd:resourceConstraints>
					<gmd:resourceConstraints>
						<gmd:MD_LegalConstraints>
							<gmd:accessConstraints>
								<gmd:MD_RestrictionCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions" codeSpace="ISOTC211/19115">otherRestrictions</gmd:MD_RestrictionCode>
							</gmd:accessConstraints>
							<gmd:accessConstraints>
								<gmd:MD_RestrictionCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode" codeListValue="license" codeSpace="ISOTC211/19115">license</gmd:MD_RestrictionCode>
							</gmd:accessConstraints>
							<gmd:accessConstraints>
								<gmd:MD_RestrictionCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode" codeListValue="copyright" codeSpace="ISOTC211/19115">copyright</gmd:MD_RestrictionCode>
							</gmd:accessConstraints>
							<gmd:otherConstraints>
								<gco:CharacterString>There are no public access constraints to this data. Use of this data is subject to the licence identified.</gco:CharacterString>
							</gmd:otherConstraints>
						</gmd:MD_LegalConstraints>
					</gmd:resourceConstraints>								
				</xsl:if>
				<xsl:if test="contains(.,'Open Government Licence')">
					<gmd:resourceConstraints>
						<gmd:MD_Constraints>
							<gmd:useLimitation>
								<gco:CharacterString><xsl:value-of select="."></xsl:value-of></gco:CharacterString>
							</gmd:useLimitation>
						</gmd:MD_Constraints>
					</gmd:resourceConstraints>
					<gmd:resourceConstraints>
						<gmd:MD_LegalConstraints>
							<gmd:accessConstraints>
								<gmd:MD_RestrictionCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions" codeSpace="ISOTC211/19115">otherRestrictions</gmd:MD_RestrictionCode>
							</gmd:accessConstraints>
							<gmd:accessConstraints>
								<gmd:MD_RestrictionCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode" codeListValue="license" codeSpace="ISOTC211/19115">license</gmd:MD_RestrictionCode>
							</gmd:accessConstraints>
							<gmd:accessConstraints>
								<gmd:MD_RestrictionCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode" codeListValue="copyright" codeSpace="ISOTC211/19115">copyright</gmd:MD_RestrictionCode>
							</gmd:accessConstraints>
							<gmd:otherConstraints>
								<gco:CharacterString>There are no public access constraints to this data. Use of this data is subject to the licence identified.</gco:CharacterString>
							</gmd:otherConstraints>
						</gmd:MD_LegalConstraints>
					</gmd:resourceConstraints>						
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		
	</xsl:template>
	
	<!-- Add generic Responsible Organisation contact after Abstract. All current ones are obliterated in the empty template above -->
	<xsl:template match="*/gmd:abstract">
			<xsl:variable name="orgName">
				<xsl:choose>
					<xsl:when test="contains($email, 'defra')">
						<xsl:value-of select="'Department for Environment Food and Rural Affairs'" />
					</xsl:when>
					<xsl:when test="contains($email, 'rpa')">
						<xsl:value-of select="'Rural Payments Agency'" />
					</xsl:when>
					<xsl:when test="contains($email, 'apha')">
						<xsl:value-of select="'Animal and Plant Health Agency'" />
					</xsl:when>
					<xsl:when test="contains($email, 'marinemanagement')">
						<xsl:value-of select="'Marine Management Organisation'" />
					</xsl:when>
					<xsl:when test="contains($email, 'naturalengland')">
						<xsl:value-of select="'Natural England'" />
					</xsl:when>
					<xsl:when test="contains($email, 'forestry')">
						<xsl:value-of select="'Forestry Commission'" />
					</xsl:when>
					<xsl:when test="contains($email, 'kew')">
						<xsl:value-of select="'Royal Botanic Gardens, Kew'" />
					</xsl:when>
				</xsl:choose>
			</xsl:variable>	
			<xsl:message>Organisation seems to be: <xsl:value-of select="$orgName" /></xsl:message>
			<xsl:variable name="orgEmail">
				<xsl:choose>
				<xsl:when test="contains($email, 'defra')">
					<xsl:value-of select="'open@defra.gsi.gov.uk'" />
				</xsl:when>
				<xsl:when test="contains($email, 'rpa')">
					<xsl:value-of select="'Open.RPA@rpa.gsi.gov.uk'" />
				</xsl:when>
				<xsl:when test="contains($email, 'apha')">
					<xsl:value-of select="'APHAOpendata@apha.gsi.gov.uk'" />
				</xsl:when>
				<xsl:when test="contains($email, 'marinemanagement')">
					<xsl:value-of select="'dkm@marinemanagement.org.uk'" />
				</xsl:when>
				<xsl:when test="contains($email, 'naturalengland')">
					<xsl:value-of select="'enquiries@naturalengland.org.uk'" />
				</xsl:when>
				<xsl:when test="contains($email, 'forestry')">
					<xsl:value-of select="'mapping.geodata@forestry.gsi.gov.uk'" />
				</xsl:when>
				<xsl:when test="contains($email, 'kew')">
					<xsl:value-of select="'info@kew.org'" />
				</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="orgURL">
				<xsl:choose>
				<xsl:when test="contains($email, 'defra')">
					<xsl:value-of select="'https://www.gov.uk/government/organisations/department-for-environment-food-rural-affairs'" />
				</xsl:when>
				<xsl:when test="contains($email, 'rpa')">
					<xsl:value-of select="'https://www.gov.uk/government/organisations/rural-payments-agency'" />
				</xsl:when>
				<xsl:when test="contains($email, 'apha')">
					<xsl:value-of select="'https://www.gov.uk/government/organisations/animal-and-plant-health-agency'" />
				</xsl:when>
				<xsl:when test="contains($email, 'marinemanagement')">
					<xsl:value-of select="'https://www.gov.uk/government/organisations/marine-management-organisation'" />
				</xsl:when>
				<xsl:when test="contains($email, 'naturalengland')">
					<xsl:value-of select="'https://www.gov.uk/government/organisations/natural-england'" />
				</xsl:when>
				<xsl:when test="contains($email, 'forestry')">
					<xsl:value-of select="'http://www.forestry.gov.uk/'" />
				</xsl:when>
				<xsl:when test="contains($email, 'kew')">
					<xsl:value-of select="'http://www.kew.org/'" />
				</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="orgURLDesc">
				<xsl:choose>
				<xsl:when test="contains($email, 'defra')">
					<xsl:value-of select="'Department for Environment Food and Rural Affairs Website'" />
				</xsl:when>
				<xsl:when test="contains($email, 'rpa')">
					<xsl:value-of select="'Rural Payments Agency Website'" />
				</xsl:when>
				<xsl:when test="contains($email, 'apha')">
					<xsl:value-of select="'Animal and Plant Health Agency Website'" />
				</xsl:when>
				<xsl:when test="contains($email, 'marinemanagement')">
					<xsl:value-of select="'Marine Management Organisation Website'" />
				</xsl:when>
				<xsl:when test="contains($email, 'naturalengland')">
					<xsl:value-of select="'Natural England Website'" />
				</xsl:when>
				<xsl:when test="contains($email, 'forestry')">
					<xsl:value-of select="'Forestry Commission Website'" />
				</xsl:when>
				<xsl:when test="contains($email, 'kew')">
					<xsl:value-of select="'The Royal Botanic Gardens, Kew Website'" />
				</xsl:when>
				</xsl:choose>
			</xsl:variable>
		
		<gmd:abstract>
			<gco:CharacterString><xsl:value-of select="./gco:CharacterString"></xsl:value-of><xsl:text> Attribution statement: </xsl:text><xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints/gco:CharacterString">
				<xsl:if test="contains(.,'copyright')"><xsl:value-of select="."></xsl:value-of><xsl:text> </xsl:text></xsl:if></xsl:for-each></gco:CharacterString>
		</gmd:abstract>
		<gmd:pointOfContact>
			<gmd:CI_ResponsibleParty>
				<gmd:organisationName>
					<gco:CharacterString><xsl:value-of select="$orgName" /></gco:CharacterString>
				</gmd:organisationName>
				<gmd:contactInfo>
					<gmd:CI_Contact>
						<gmd:address>
							<gmd:CI_Address>
								<gmd:electronicMailAddress>
									<gco:CharacterString><xsl:value-of select="$orgEmail" /></gco:CharacterString>
								</gmd:electronicMailAddress>
							</gmd:CI_Address>
						</gmd:address>
						<gmd:onlineResource>
							<gmd:CI_OnlineResource>
								<gmd:linkage>
									<gmd:URL><xsl:value-of select="$orgURL" /></gmd:URL>
								</gmd:linkage>
								<gmd:description>
									<gco:CharacterString><xsl:value-of select="$orgURLDesc" /></gco:CharacterString>
								</gmd:description>
							</gmd:CI_OnlineResource>
						</gmd:onlineResource>
					</gmd:CI_Contact>
				</gmd:contactInfo>
				<gmd:role>
					<gmd:CI_RoleCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact" codeSpace="ISOTC211/19115">pointOfContact</gmd:CI_RoleCode>
				</gmd:role>
			</gmd:CI_ResponsibleParty>
		</gmd:pointOfContact>
	</xsl:template>
	
	<!-- replace with generic Metadata Contact -->
	<xsl:template match="*/gmd:contact">
		
		<xsl:variable name="orgName">
			<xsl:choose>
				<xsl:when test="contains($email, 'defra')">
					<xsl:value-of select="'Department for Environment Food and Rural Affairs'" />
				</xsl:when>
				<xsl:when test="contains($email, 'rpa')">
					<xsl:value-of select="'Rural Payments Agency'" />
				</xsl:when>
				<xsl:when test="contains($email, 'apha')">
					<xsl:value-of select="'Animal and Plant Health Agency'" />
				</xsl:when>
				<xsl:when test="contains($email, 'marinemanagement')">
					<xsl:value-of select="'Marine Management Organisation'" />
				</xsl:when>
				<xsl:when test="contains($email, 'naturalengland')">
					<xsl:value-of select="'Natural England'" />
				</xsl:when>
				<xsl:when test="contains($email, 'forestry')">
					<xsl:value-of select="'Forestry Commission'" />
				</xsl:when>
				<xsl:when test="contains($email, 'kew')">
					<xsl:value-of select="'Royal Botanic Gardens, Kew'" />
				</xsl:when>
			</xsl:choose>
		</xsl:variable>			  
		<xsl:variable name="orgEmail">
			<xsl:choose>
			<xsl:when test="contains($email, 'defra')">
				<xsl:value-of select="'open@defra.gsi.gov.uk'" />
			</xsl:when>
			<xsl:when test="contains($email, 'rpa')">
				<xsl:value-of select="'Open.RPA@rpa.gsi.gov.uk'" />
			</xsl:when>
			<xsl:when test="contains($email, 'apha')">
				<xsl:value-of select="'APHAOpendata@apha.gsi.gov.uk'" />
			</xsl:when>
			<xsl:when test="contains($email, 'marinemanagement')">
				<xsl:value-of select="'dkm@marinemanagement.org.uk'" />
			</xsl:when>
			<xsl:when test="contains($email, 'naturalengland')">
				<xsl:value-of select="'enquiries@naturalengland.org.uk'" />
			</xsl:when>
			<xsl:when test="contains($email, 'forestry')">
				<xsl:value-of select="'mapping.geodata@forestry.gsi.gov.uk'" />
			</xsl:when>
			<xsl:when test="contains($email, 'kew')">
				<xsl:value-of select="'info@kew.org'" />
			</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<gmd:contact>
			<gmd:CI_ResponsibleParty>
				<gmd:organisationName>
					<gco:CharacterString><xsl:value-of select="$orgName" /></gco:CharacterString>
				</gmd:organisationName>
				<gmd:contactInfo>
					<gmd:CI_Contact>
						<gmd:address>
							<gmd:CI_Address>
								<gmd:electronicMailAddress>
									<gco:CharacterString><xsl:value-of select="$orgEmail" /></gco:CharacterString>
								</gmd:electronicMailAddress>
							</gmd:CI_Address>
						</gmd:address>
					</gmd:CI_Contact>
				</gmd:contactInfo>
				<gmd:role>
					<gmd:CI_RoleCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact" codeSpace="ISOTC211/19115">pointOfContact</gmd:CI_RoleCode>
				</gmd:role>
			</gmd:CI_ResponsibleParty>
		</gmd:contact>
	</xsl:template>
	
	<!-- Removes any reference to DSTR IDs -->
	<xsl:template match="*/gmd:identifier">
		<xsl:variable name="URI2"><xsl:value-of select="./gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/></xsl:variable>	
		<xsl:if test="not(contains($URI2,'DSTR'))">
			<gmd:identifier>
				<xsl:apply-templates select="@* | node()"/>
			</gmd:identifier>
		</xsl:if>
	</xsl:template>
	
	<!-- Remove internal Resource Locators -->
	<xsl:template match="*/gmd:transferOptions">
		<gmd:transferOptions>
			<gmd:MD_DigitalTransferOptions>
				<xsl:for-each select="./gmd:MD_DigitalTransferOptions/gmd:onLine">
					<xsl:variable name="URL"><xsl:value-of select="./gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/></xsl:variable>
					<xsl:variable name="protocol"><xsl:value-of select="./gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString"/></xsl:variable>
					<xsl:if test="contains($URL,'http')">
						<xsl:if test="not(contains($URL,'intranet.ea.gov'))">
							<gmd:onLine>
								<gmd:CI_OnlineResource>
									<gmd:linkage>
										<gmd:URL><xsl:value-of select="$URL"/></gmd:URL>
									</gmd:linkage>
									<gmd:protocol>
										<gco:CharacterString><xsl:value-of select="$protocol"/></gco:CharacterString>
									</gmd:protocol>	  
								</gmd:CI_OnlineResource>
							</gmd:onLine>
						</xsl:if>  
					</xsl:if>
				</xsl:for-each>	
			</gmd:MD_DigitalTransferOptions>
		</gmd:transferOptions>
	</xsl:template>
	
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
	
</xsl:stylesheet>
