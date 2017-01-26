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
	<xsl:param name="graph.rankdir">LR</xsl:param><!-- "TB" -->
	<!-- optional color parameter(s) -->
	<xsl:param name="project.node.fill.color">#CCCCCC</xsl:param>
	<xsl:param name="project.node.font.color">#000000</xsl:param>
	<xsl:param name="local.node.fill.color">#FFFFFF</xsl:param>
	<xsl:param name="local.node.font.color">#000000</xsl:param>
	<xsl:param name="foreign.node.fill.color">#AAAAAA</xsl:param>
	<xsl:param name="foreign.node.font.color">#000000</xsl:param>
	<xsl:param name="subgraph.fill.color">#FFFFFF</xsl:param>

	<xsl:template match="/Artifact:Artifact">
		<!-- STEP 1: generate the DOT header -->
		<xsl:apply-templates select="dataModel" />
		<!-- STEP 2: generate the DOT header -->
		
		<xsl:call-template name="create-local-node">
			<xsl:with-param name="type.name" select="concat('dm_document')" />
			<xsl:with-param name="super.name" select="concat('dm_sysobject')" />
		</xsl:call-template>
		<xsl:call-template name="create-local-node">
			<xsl:with-param name="type.name" select="concat('dm_folder')" />
			<xsl:with-param name="super.name" select="concat('dm_sysobject')" />
		</xsl:call-template>
		<xsl:call-template name="create-local-node">
			<xsl:with-param name="type.name" select="concat('dm_sysobject')" />
			<xsl:with-param name="super.name" select="concat('__UNDEF__')" />
		</xsl:call-template>
		
		<xsl:apply-templates select="dataModel/artifacts" />

		<!-- STEP FINAL: generate the DOT footer -->
		<xsl:call-template name="create-dot-footer" />
	</xsl:template>

	<xsl:template match="dataModel">
		<xsl:variable name="graph.label">
			<xsl:value-of select="@name" />
		</xsl:variable>
		<xsl:call-template name="create-dot-header">
			<xsl:with-param name="dot.graph.label" select="$graph.label" />
			<xsl:with-param name="dot.graph.rankdir" select="$graph.rankdir" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="artifacts[@xsi:type='dclass:DClass']">

		<xsl:variable name="type.name">
			<xsl:value-of select="substring-before(substring-after(@href,'/'), '?')" />
		</xsl:variable>
		<xsl:variable name="type.file">
			<xsl:value-of
				select="concat($artifacts.dir, '/Types/', $type.name, '.type')" />
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

			<!-- <xsl:value-of select="concat($type.name,', ', $super.name, ', ', 
				$super.name.full, ', ', $type.file)" /> 
			<xsl:text>
</xsl:text>
			<xsl:value-of select="concat($type.name,', ', $super.name)" />
			-->
			
		<!-- STEP 1: generate the DOT header -->
		<xsl:call-template name="create-local-node">
			<xsl:with-param name="type.name" select="$type.name" />
			<xsl:with-param name="super.name" select="$super.name" />
		</xsl:call-template>
			
		</xsl:if>
	</xsl:template>


	<!-- named templates -->
	<!-- (these - and only these - templates generate DOT output) -->

	<xsl:template name="create-dot-header">
		<xsl:param name="dot.graph.rankdir">LR</xsl:param>
		<xsl:param name="dot.graph.label">__UNDEF__</xsl:param>
		strict digraph "<xsl:value-of select="$dot.graph.label" />" {

		graph [
		 fontsize=10,
		 fontcolor=black,
		 fontname=Courier,
		 rankdir =<xsl:value-of select="$dot.graph.rankdir" />
		];

		node [
		 fontsize=8,
		 fontcolor=black,
		 fontname=Courier,
		 shape=box,
		 color=black,
		 style="bold, filled"
		];

		edge [
		 fontsize=6,
		 fontcolor=black,
		 fontname=Courier
		];

		subgraph cluster_project {

		 style=filled;
		 fillcolor="<xsl:value-of select="$subgraph.fill.color" />";

		 label="<xsl:value-of select="$dot.graph.label" />";
		 labelloc=b;
		 labeljust=r;

	</xsl:template>

	<xsl:template name="create-local-node">
		<xsl:param name="type.name">__UNDEF__</xsl:param>
		<xsl:param name="super.name">__UNDEF__</xsl:param>
		
		"<xsl:value-of select="normalize-space($type.name)"/>" [ 
		 label="<xsl:value-of select="normalize-space($type.name)"/>"  
		 , fillcolor="<xsl:value-of select="$local.node.fill.color"/>"
		 , fontcolor="<xsl:value-of select="$local.node.font.color"/>"
		];
		<xsl:if test="$super.name != '__UNDEF__'">
			"<xsl:value-of select="normalize-space($type.name)"/>" -> "<xsl:value-of select="normalize-space($super.name)"/>"
		</xsl:if> 

	</xsl:template>

	<xsl:template name="create-dot-footer">
		}<!-- terminate cluster subgraph -->
		}<!-- terminate digraph -->
	</xsl:template>

</xsl:stylesheet>