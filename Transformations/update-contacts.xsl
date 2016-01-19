<xsl:stylesheet version="1.0" exclude-result-prefixes="eamp"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:gmd="http://www.isotc211.org/2005/gmd"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:eamp="http://environment.data.gov.uk/eamp"
            xmlns:gco="http://www.isotc211.org/2005/gco"
            xmlns:gml="http://www.opengis.net/gml"
            xmlns:srv="http://www.isotc211.org/2005/srv"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
            <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
            <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
            <xsl:template match="*/gmd:pointOfContact">
                 <gmd:pointOfContact>
                     <xsl:variable name="email">
                         <xsl:value-of select="translate(./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString, $uppercase, $lowercase)"/>
                     </xsl:variable>
                     <xsl:if test=\"contains($email,\'''' + namedict["oldEmail"] + '''\')\">
                         <gmd:CI_ResponsibleParty>
                             <gmd:individualName>
                                 <gco:CharacterString>''' + namedict["newName"] + '''</gco:CharacterString>
                             </gmd:individualName>
                             <gmd:organisationName>
                                 <gco:CharacterString>''' + namedict["newOrg"] + '''</gco:CharacterString>
                             </gmd:organisationName>
                             <gmd:positionName>
                                 <gco:CharacterString>''' + namedict["newPos"] + '''</gco:CharacterString>
                             </gmd:positionName>
                             <gmd:contactInfo>
                                 <gmd:CI_Contact>
                                     <gmd:address>
                                         <gmd:CI_Address>
                                             <gmd:electronicMailAddress>
                                                 <gco:CharacterString>''' + namedict["newEmail"] + '''</gco:CharacterString>
                                             </gmd:electronicMailAddress>
                                         </gmd:CI_Address>
                                     </gmd:address>
                                 </gmd:CI_Contact>
                             </gmd:contactInfo>
                             <gmd:role>
                                 <gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="''' + namedict["newRole"] + '''"/>
                             </gmd:role>
                         </gmd:CI_ResponsibleParty>
                     </xsl:if>
                     <xsl:if test=\"not(contains($email,\'''' + namedict["oldEmail"] + '''\'))\">
                         <xsl:apply-templates select="@* | node()"/>
                     </xsl:if>
                 </gmd:pointOfContact>
            </xsl:template>
           <xsl:template match="node() | @*">
              <xsl:copy>
               <xsl:apply-templates select="node() | @*"/>
              </xsl:copy>
          </xsl:template>
            </xsl:stylesheet>