<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">                
    
    <xsl:template match="entity">       
        <div class='row'>
            <div class='large-1 columns'>ID</div>
            <div class='large-11 columns'>
                <xsl:value-of select="@id"/>
            </div>
        </div>
        <xsl:choose>
           <xsl:when test="@type='person'">                
                <xsl:if test="@uri != ''">
                    <div class='row'>
                        <div class='large-1 columns'>URI</div>
                        <div class='large-11 columns'>
                            <a>
                                <xsl:attribute name='href' select='@uri'/>                    
                                <xsl:value-of select="@uri"/>
                            </a>
                        </div>
                    </div>
                </xsl:if>        
                <div class='row'>
                    <div class='large-1 columns'>Name:</div>            
                    <div class='large-11 columns'><xsl:value-of select="@name"/></div>            
                </div>
                <xsl:if test="@birth != ''">    
                    <div class='row'>
                            <div class='large-1 columns'>Birth: </div>
                            <div class='large-11 columns'><xsl:value-of select="@birth"/></div>
                    </div>        
                </xsl:if>
                <xsl:if test="@death != ''">   
                    <div class='row'>
                        <div class='large-1 columns'>Death: </div>
                        <div class='large-11 columns'><xsl:value-of select="@death"/></div>        
                    </div>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>               
               <div class='row'>
                    <div class='large-1 columns'>Name:</div>            
                    <div class='large-11 columns'><xsl:value-of select="@name"/></div>            
                </div>
                <xsl:if test="@location-type != ''">
                    <div class='row'>
                        <div class='large-1 columns'>Type:</div>            
                        <div class='large-11 columns'><xsl:value-of select="@location-type"/></div>            
                    </div>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
  </xsl:template>    
    
    <xsl:template match="files">    
        <xsl:apply-templates select="file"/> 
    </xsl:template>
   
   <xsl:template match="file">        
        <xsl:if test='person/@id or place/@id'>
            <tr>
                <td><a href="/letter/{@xmlid}.html"><xsl:value-of select='@xmlid'/></a></td>
                <td class='date' style='visibility:hidden'><xsl:value-of select='@publication_date'/></td>
                <td><xsl:value-of select='@title'/></td>
                
            </tr>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>

