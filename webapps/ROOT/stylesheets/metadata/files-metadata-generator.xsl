<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
                version="2.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Create a file element with attributes specifying some useful
       metadata from the source TEI document.

       This repeats some of what the Solr indexing does, and is
       intended simply as an alternative to Solr indexing in the
       simplest of cases. -->

  <xsl:output indent="yes" method="xml" />

  <xsl:param name="path"/>
  <xsl:param name="ref"/>

  <xsl:template match="/">
    <file path="{replace($path, '.xml', '')}" xml_path="{$path}">
      <xsl:attribute name="id" select="tei:TEI/@xml:id" />
    <xsl:attribute name="ref" select="$ref" />       
      <xsl:apply-templates select="tei:TEI/tei:teiHeader" />
    </file>
  </xsl:template>

  <xsl:template match="tei:fileDesc/tei:titleStmt/tei:title">
    <xsl:if test="not(preceding-sibling::tei:title)">
      <xsl:attribute name="title" select="normalize-space(.)" />
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:fileDesc/tei:titleStmt/tei:author/tei:name">
      <xsl:attribute name="author" select="normalize-space(.)" />
  </xsl:template>

  <xsl:template match="tei:fileDesc/tei:titleStmt/tei:editor">
      <xsl:attribute name="editor" select="normalize-space(.)" />
  </xsl:template>

  <xsl:template match="tei:profileDesc/tei:creation/tei:date">
    <xsl:attribute name="publication_date" select="@when/normalize-space(.)" />
  </xsl:template>
  
  <xsl:template match="tei:fileDesc/tei:notesStmt/tei:note/tei:list//tei:item[last()-1]/tei:figure/tei:graphic">
        <xsl:attribute name="envelope_url" select="@url/normalize-space(.)" />
  </xsl:template>
  
  <xsl:template match="text()"/>

</xsl:stylesheet>
