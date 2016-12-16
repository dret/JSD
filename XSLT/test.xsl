<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
  <xsl:include href="JSONPath.xsl"/>
  <xsl:include href="validator.xsl"/>
  <xsl:output method="xml" _omit-xml-declaration="yes"/>
  <xsl:variable name="input" select="('RFC7159-example-1.json', 'RFC7159-example-2.json')"/>
  <xsl:template match="/">
    <xsl:for-each select="$input">
      <xsl:variable name="JSON" select="unparsed-text(.)"/>
      <xsl:value-of select="concat(., ':&#xa;')"/>
      <xsl:call-template name="JSONPath">
        <xsl:with-param name="JSON" select="$JSON"/>
      </xsl:call-template>
      <xsl:call-template name="validate">
        <xsl:with-param name="JSON" select="$JSON"/>
        <xsl:with-param name="JSDOM" select="doc('RFC7159-example-1.jsdom')"/>
      </xsl:call-template>
      <xsl:text>&#xa;&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>