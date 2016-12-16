<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0" xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="JSDXML" select="json-to-xml(unparsed-text('RFC7159-example-1.jsd'))"/>
  <xsl:template match="/">
    <jsd>
      <xsl:copy-of select="$JSDXML"/>
      <xsl:for-each select="$JSDXML/map/map">
        <rule name="{@key}">
          <xsl:variable name="type" select="map/@key"/>
          <xsl:choose>
            <xsl:when test="$type eq '$object'">
              <object>
                
              </object>
            </xsl:when>
            <xsl:when test="$type eq '$array'">
              <array>
                
              </array>
            </xsl:when>
            <xsl:when test="$type eq '$number'">
              <number>
                
              </number>
            </xsl:when>
            <xsl:when test="$type eq '$string'">
              <string>
                
              </string>
            </xsl:when>
            <xsl:when test="$type eq '$boolean'">
              <boolean>
                
              </boolean>
            </xsl:when>
            <xsl:when test="$type eq '$null'">
              <null/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:message>Unknown rule type</xsl:message>
            </xsl:otherwise>
          </xsl:choose>
        </rule>
      </xsl:for-each>
    </jsd>
  </xsl:template>
</xsl:stylesheet>
