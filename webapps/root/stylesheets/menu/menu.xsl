<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- For the main menu, display only the top level items. -->
  <xsl:template match="/aggregation/xhtml:div[@type='menu']" mode="main-menu">
    <xsl:apply-templates mode="main-menu" />
  </xsl:template>

  <xsl:template match="xhtml:li/xhtml:ul" mode="main-menu" />

  <!-- For the local menu, display only the siblings of the active
       item. -->
  <xsl:template match="/aggregation/xhtml:div[@type='menu']"
                mode="local-menu">
    <xhtml:ul>
      <xsl:apply-templates
          select=".//xhtml:ul[xhtml:li/@class='active-menu-item']/xhtml:li"
          mode="local-menu" />
    </xhtml:ul>
  </xsl:template>

  <xsl:template match="xhtml:li/xhtml:ul" mode="local-menu" />

  <xsl:template match="@*|node()" mode="#all">
    <xsl:copy>
      <xsl:apply-templates mode="#current" select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>