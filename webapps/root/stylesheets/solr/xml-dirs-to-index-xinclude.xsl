<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:dir="http://apache.org/cocoon/directory/2.0"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- XSLT to generate XInclude elements to index each XML document
       in the source document's directory listing. -->

  <xsl:template match="dir:directory">
    <xincludes>
      <!-- Exclude the content directory from the path. -->
      <xsl:apply-templates select="*" />
    </xincludes>
  </xsl:template>

  <xsl:template match="dir:directory/dir:directory" priority="100">
    <xsl:param name="path" select="''" />
    <xsl:variable name="new_path" select="concat($path, @name, '/')" />
    <xsl:apply-templates select="dir:file">
      <xsl:with-param name="path" select="$new_path" />
    </xsl:apply-templates>
    <xsl:apply-templates select="dir:directory">
      <xsl:with-param name="path" select="$new_path" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="dir:file">
    <xsl:param name="path" />

    <xsl:variable name="filepath">
      <xsl:value-of select="$path" />
      <xsl:value-of select="@name" />
    </xsl:variable>

    <file><xsl:value-of select="$filepath" /></file>
    <xi:include href="tei/{$filepath}" />
  </xsl:template>

</xsl:stylesheet>