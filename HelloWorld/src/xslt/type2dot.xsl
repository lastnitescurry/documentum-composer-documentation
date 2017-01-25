<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/XMI"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:Artifact="http://documentum.emc.com/infrastructure/12012007/artifact"
	xmlns:dardef="http://documentum.emc.com/infrastructure/12012007/dardef"
	xmlns:dclass="http://documentum.emc.com/artifact/12012007/dclass">

	<xsl:output method="text" indent="no" encoding="iso-8859-1" />
	<xsl:strip-space elements="*" />
	<!-- global graph parameter(s) -->
	<xsl:param name="artifacts.dir">Artifacts</xsl:param>

	<xsl:template match="/Artifact:Artifact/dataModel">
		<xsl:apply-templates select="artifacts" />
	</xsl:template>
	<xsl:template match="artifacts[@xsi:type='dclass:DClass']">

		<xsl:variable name="type.name">
			<xsl:value-of select="substring-before(substring-after(@href,'/'), '?')" />
		</xsl:variable>
		<xsl:variable name="type.file">
			<xsl:value-of select="concat($artifacts.dir, '/Types/', $type.name, '.type')" />
		</xsl:variable>
		<xsl:if test="$type.name != 'dmc_dar'">
			<xsl:variable name="super.name.full">
				<xsl:value-of
					select="document($type.file)/Artifact:Artifact/dataModel/type/super_name/@href" />
			</xsl:variable>
			<xsl:variable name="super.name">
				<xsl:value-of
					select="substring-before(substring-after($super.name.full,'/'), '?')" />
			</xsl:variable>

<xsl:value-of select="concat($type.name,', ', $super.name, ', ', $super.name.full, ', ', $type.file)" />
			<xsl:text>
</xsl:text>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>