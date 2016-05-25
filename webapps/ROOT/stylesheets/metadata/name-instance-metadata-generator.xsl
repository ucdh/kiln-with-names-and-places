<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
                version="2.0"
                xmlns:mads="http://www.loc.gov/mads/"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
   <xsl:output indent="yes" method="xml" />    
    
    <xsl:param name="ref"/>     
       
    <xsl:param name="path"/>

    
   <xsl:template match="mads:madsCollection">
        <xsl:for-each select='mads:mads'>
            <xsl:if test="@id = $ref"> 
                <entity>
                    <xsl:attribute name='id' select='@id'/>
                    <xsl:attribute name='uri' select='mads:authority/@valueURI'/>
                    <xsl:apply-templates select='mads:authority'/>                        
                </entity>
            </xsl:if>    
        </xsl:for-each>                
    </xsl:template>
 
   <xsl:template match='mads:name'>
        <xsl:attribute name='type'>person</xsl:attribute>
        
        <xsl:variable name='date' select="tokenize(mads:namePart[@type='date'],'-')"/>
        <xsl:attribute name='birth' select="$date[1]"/>
         <xsl:attribute name='death' select="$date[2]"/>
        
        <xsl:choose>
            <xsl:when test="mads:namePart[@type='given'] and mads:namePart[@type='family']">
                <xsl:attribute name='name' select="concat(mads:namePart[@type='given'],' ',mads:namePart[@type='family'])"/>            
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="mads:namePart">
                        <xsl:attribute name='name' select="*"/>    
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name='name' select="current()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>        
   </xsl:template>
   
   <xsl:template match="mads:geographic">        
        <xsl:attribute name='type'>place</xsl:attribute>
        <xsl:attribute name='name' select='normalize-space(.)'/>
        <xsl:attribute name='location-type' select='name(*)'/>
    </xsl:template>
    
    <xsl:template match="mads:hierachicalGeographic">
        <xsl:attribute name='type'>place</xsl:attribute>
        <xsl:attribute name='name' select="concat(*[1],', ', *[2])"/>
        <xsl:attribute name='location-type' select='name(*[1])'/>        
    </xsl:template>
   
   <xsl:template match="tei:TEI">
    <file path="{replace($path, '.xml', concat('/', $ref))}" xml_path="{$path}">
      <xsl:attribute name="xmlid" select="@xml:id" />
      <xsl:apply-templates select="tei:teiHeader"/>
    </file>
  </xsl:template>
  
  <xsl:template match="tei:fileDesc/tei:titleStmt/tei:title">
    <xsl:if test="not(preceding-sibling::tei:title)">
      <xsl:attribute name="title" select="normalize-space(.)" />
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:profileDesc/tei:creation/tei:date">
    <xsl:attribute name="publication_date" select="@when/normalize-space(.)" />
  </xsl:template>
  
  <xsl:template match="tei:particDesc/tei:listPerson">
    <xsl:for-each select="tei:person">        
        <xsl:if test="@xml:id=$ref">   
            <person>
                <xsl:attribute name="id" select='@xml:id'/>
            </person>
        </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="tei:settingDesc/tei:listPlace">
    <xsl:for-each select="tei:place">        
        <xsl:if test="@xml:id=$ref">   
            <place>
                <xsl:attribute name="id" select='@xml:id'/>
            </place>
        </xsl:if>
    </xsl:for-each>
  </xsl:template>
   
    <xsl:template match="text()"/>
  

</xsl:stylesheet>
