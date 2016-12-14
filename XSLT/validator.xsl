<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0" xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
  <xsl:output method="xml"/>
  <xsl:template name="validate">
    <xsl:param name="JSON" select="'null'"/>
    <xsl:param name="JSDOM">
      <jsd/>
    </xsl:param>
    <xsl:variable name="JSDOM-denormalized" xpath-default-namespace="">
      <xsl:apply-templates select="$JSDOM/jsd/value[@id eq '$root']" mode="JSDOM"/>
    </xsl:variable>
    <xsl:copy-of select="$JSDOM-denormalized"/>
    <xsl:apply-templates select="json-to-xml($JSON)/*">
      <xsl:with-param name="context" select="$JSDOM/jsd/value[@id eq '$root']"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="value[exists(@name)]" xpath-default-namespace="" mode="JSDOM">
    <xsl:apply-templates select="ancestor::jsd/value[@id eq current()/@name]/*"/>
  </xsl:template>
  <xsl:template match=" node() | @* " xpath-default-namespace="" mode="JSDOM">
    <xsl:copy>
      <xsl:apply-templates select=" @* | node() "/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="map">
    <xsl:param name="context"/>
  </xsl:template>
</xsl:stylesheet>
