
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xmi="http://www.omg.org/XMI"
	xmlns:Artifact="http://documentum.emc.com/infrastructure/12012007/artifact">
<xsl:output method="text" />
  <xsl:strip-space elements="*" />  
	<xsl:template match="/">  
# Documentum Type - <xsl:value-of select="Artifact:Artifact/dataModel/type/@name" />
-----------------------------------------------------------------------------------

					<xsl:for-each select="Artifact:Artifact/dataModel/type">
Type Name:  <xsl:value-of select="@name" />

Type Label: <xsl:value-of select="primaryElement/typeAnnotations/locales/@label_text" />

Developer Comment:  <xsl:value-of select="primaryElement/typeAnnotations/locales/@comment_text" />

Help Text:  <xsl:value-of select="primaryElement/typeAnnotations/locales/@help_text" />

          </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
