<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
                version="2.0"
                xmlns:mads="http://www.loc.gov/mads/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output indent="yes" method="xml" />    
    
    <xsl:param name="letter"/>
     
    <xsl:template match="/">                    
            <file>
            <xsl:for-each select='mads:madsCollection/mads:mads'>
            <entity letter='{$letter}'>
                    <xsl:attribute name="id" select="@id"/>
                    <xsl:apply-templates select="mads:authority"/>
                </entity>
                 
            </xsl:for-each>
            </file>
        <alphabet>
            1,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z            
        </alphabet>
    </xsl:template>
 
    <xsl:template match="mads:name">        
        <xsl:attribute name='type'>person</xsl:attribute>
        <xsl:choose>
            <xsl:when test="mads:namePart">               
                <xsl:choose>
                    <xsl:when test="mads:namePart[@type='given'] and mads:namePart[@type='family']">
                        <xsl:attribute name='initial' select="substring(mads:namePart[@type='family'],1,1)"/>
                        <xsl:attribute name='name' select="concat(mads:namePart[2]/normalize-space(.),', ', mads:namePart[1]/normalize-space(.))"/>                
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name='initial' select="substring(mads:namePart,1,1)"/>
                        <xsl:attribute name='name' select="mads:namePart/normalize-space(.)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>                
                <xsl:attribute name='initial' select="substring(.,1,1)"/>
                <xsl:attribute name='name' select="normalize-space(.)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mads:geographic">        
        <xsl:attribute name='type'>place</xsl:attribute>
        <xsl:attribute name='name' select='normalize-space(.)'/>
        <xsl:choose>
            <xsl:when test='*'>
                <xsl:attribute name='initial' select="substring(normalize-space(*),1,1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name='initial' select="substring(normalize-space(current()),1,1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mads:hierachicalGeographic">
        <xsl:attribute name='type'>place</xsl:attribute>
        <xsl:attribute name='name' select="concat(*[1],', ', *[2])"/>
        <xsl:attribute name='initial' select="substring(*[1],1,1)"/>
    </xsl:template>
   
<xsl:template match="text()"/>
  

</xsl:stylesheet>
