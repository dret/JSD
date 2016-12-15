<?xml version="1.0" encoding="UTF-8"?>
<!-- "JSONPath" accepts a JSON string as input and returns a sequence of JSONPath expressions for each individual value in the JSON input. XSLT 3.0 is required. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
  <xsl:template name="JSONPath">
    <xsl:param name="JSON" select="'null'"/>
    <xsl:apply-templates select="json-to-xml($JSON)/*" mode="JSONPath">
      <xsl:with-param name="JSONPath" select="'  $'"/>
    </xsl:apply-templates>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
  <xsl:template match="map" mode="JSONPath">
    <xsl:param name="JSONPath"/>
    <xsl:apply-templates select="*" mode="JSONPath">
      <xsl:with-param name="JSONPath" select="concat($JSONPath, @key, '.')"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="array" mode="JSONPath">
    <xsl:param name="JSONPath"/>
    <xsl:for-each select="*">
      <xsl:apply-templates select="." mode="JSONPath">
        <xsl:with-param name="JSONPath" select="concat($JSONPath, ../@key, '[', position()-1 ,']')"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match=" string | number | boolean | null " mode="JSONPath">
    <xsl:param name="JSONPath"/>
    <xsl:value-of select="concat($JSONPath, @key, ' --> &quot;', text(), '&quot; (', local-name(),')&#xa;')"/>
  </xsl:template>
</xsl:stylesheet>