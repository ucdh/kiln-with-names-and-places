<?xml version="1.0"?>
<!-- convert MADS authority file to html page showing names starting with a given initial --> 
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                
    <xsl:template match='file'>
        <xsl:if test="entity[@type='person']/@initial = entity/@letter">        
            <div id='people' class='small-3 large-6 columns'>
                <h4>People</h4>
                <ul class='person'>                
                    <xsl:apply-templates select="entity[@type='person']"/>
                </ul>
            </div>
        </xsl:if>
        <xsl:if test="entity[@type='place']/@initial = entity/@letter">
           <div id='place' class='small-3 large-6 columns'>
                <h4>Places</h4>
                <ul class='place'>
                    <xsl:apply-templates select="entity[@type='place']"/>
                </ul>
            </div>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="entity[@type='person']">
            <xsl:if test="@initial=@letter and @type='person'">                
                <li>
                    <a>
                     <xsl:attribute name='href'>
                            <xsl:value-of select="concat('/id/',@id)"/>
                        </xsl:attribute>
                        <xsl:value-of select='@name'/>
                    </a>
                </li>
            </xsl:if>            
    </xsl:template>
    
    <xsl:template match="entity[@type='place']">
            <xsl:if test="@initial=@letter and @type='place'">                
                <li>
                    <a>
                        <xsl:attribute name='href'>
                            <xsl:value-of select="concat('/id/',@id)"/>
                        </xsl:attribute>
                        <xsl:value-of select='@name'/>
                    </a>
                    
                </li>
            </xsl:if>            
    </xsl:template>
    
    
    <xsl:template match='alphabet'>
        <xsl:variable name='alphabet_lst' select="tokenize(normalize-space(current()),',')"/>
        <table>
            <tr>
                <xsl:for-each select="$alphabet_lst">           
                    <td>
                        <a href='{.}'>
                            <xsl:value-of select="."/>
                        </a>
                    </td>
                </xsl:for-each>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>

