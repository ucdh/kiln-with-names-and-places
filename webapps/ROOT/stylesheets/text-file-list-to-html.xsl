<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="files" mode="text-index">
    <ul class="small-block-grid-5 medium-block-grid-2">
        <xsl:apply-templates mode="text-index" select="file"/>
      </ul>
  </xsl:template>

    <xsl:template match="file" mode="text-index">        
        <li>
                
            <span class='date' style='visibility:hidden'>
            <xsl:variable name='date' select="@publication_date"/>
            <xsl:if test="$date != ''">
                    <xsl:value-of select="@publication_date"/>
            </xsl:if> 
            </span>            
            <br/> 
                
            <a href="{@path}.html" style='border:none'>
            <th>       
                <div class='image' style="height:157px">
                <img>
                    
                    <xsl:attribute name="src">
                        <xsl:variable name='envelope' select="@envelope_url"/>
                        <xsl:choose>
                            <xsl:when test="contains($envelope,'env')">
                                <xsl:copy-of select="concat('/images/',@id,'/',@envelope_url)"/>
                            </xsl:when>
                            <xsl:otherwise>/assets/images/envelope/envelope.jpg</xsl:otherwise>
                        </xsl:choose>                       
                    </xsl:attribute>
                </img>
                </div>
           </th>
           </a>
           </li>        
    </xsl:template>
    
</xsl:stylesheet>
