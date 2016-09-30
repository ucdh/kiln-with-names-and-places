<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
                xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Transform a TEI document's teiHeader into HTML. -->
  <xsl:template match="tei:teiHeader">
    <!-- Display metadata about this document, drawn from the TEI
         header. -->
    <div class="section-container accordion" data-section="accordion">
      <section>
      <h2 class="title" data-section-title="">
        <small><a href="#">Document details</a></small>
      </h2>
      <div class="content" data-section-content="">
            <p style="visbility:hidden">
                <strong>Creation date: </strong>
                <span class='date'><xsl:value-of select="tei:profileDesc/tei:creation/tei:date/@when"/></span>
            </p>
            <p>
                <strong>Title: </strong>
                <xsl:value-of select='tei:fileDesc/tei:titleStmt/tei:title/normalize-space(.)'/>
            </p>
            <p>
            <strong>
              <xsl:text>Author: </xsl:text>
            </strong>
            <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:author/tei:name/normalize-space(.)"/>
            </p>
      </div>
    </section>
    <section>
        <h2 class='title' data-section-title="">
            <small><a href="#">Publication details</a></small>
        </h2>
        <div class="content" data-section-content="">
            <p>
                <strong>Funder: </strong>
                <xsl:value-of select='tei:fileDesc/tei:titleStmt/tei:funder/normalize-space(.)'/>
            </p>
            <p><strong>Publisher: </strong>
                <xsl:value-of select='tei:fileDesc/tei:publicationStmt/tei:publisher'/>
            </p>
            <p>
                <strong>Publication Place: </strong>
                <xsl:value-of select='tei:fileDesc/tei:publicationStmt/tei:pubPlace'/>
            </p>
            <p>
                <strong>Date published </strong>
                <xsl:value-of select='tei:fileDesc/tei:publicationStmt/tei:date'/>
            </p>
            <p>
                <strong>Licence: </strong>
                <xsl:value-of select='tei:fileDesc/tei:publicationStmt/tei:availability'/>
            </p>
            <img src='{$kiln:assets-path}/images/licence button/by-sa88x31.jpg'/>
        </div>
    </section>
    <section>
        <h2 class='title' data-section-title="">
            <small><a href='#'>Creation details</a></small>
        </h2>
        <div class='content' data-section-content=''>
          <xsl:for-each select='tei:fileDesc/tei:titleStmt/tei:respStmt'>
              <p>
              <strong>
                <xsl:value-of select="tei:resp" />
                <xsl:text>: </xsl:text>
              </strong>
              <xsl:value-of select='*[2]'/>
              <xsl:if test="*[3]">
                <xsl:text> &amp; </xsl:text>
                <xsl:value-of select="*[3]"/>
              </xsl:if>
            </p>
            </xsl:for-each>
        </div>
    </section>
    <xsl:apply-templates select="tei:encodingDesc"/>
    <section>
        <h2 class='title' data-section-title="">
            <small><a href='#'>Envelope images</a></small>
        </h2>
        <div class='content' data-section-content=''>
            <xsl:variable name='image_list' select='tei:fileDesc/tei:notesStmt/tei:note/tei:list'/>
            <xsl:variable name='root' select='ancestor::tei:TEI'/>
            <xsl:choose>
                <xsl:when test="contains($image_list//tei:item[last()-1]/tei:figure/tei:graphic/@url,'envf')">
                    <a href="{$kiln:content-path}/images/{$root/@xml:id}/{$image_list//tei:item[last()-1]/tei:figure/tei:graphic/@url}" data-lightbox='envelope'>
					<img src='{$kiln:content-path}/images/{$root/@xml:id}/{$image_list//tei:item[last()-1]/tei:figure/tei:graphic/@url}'/>
                    </a>
					<br/>
					<a href="{$kiln:content-path}/images/{$root/@xml:id}/{$image_list//tei:item[last()]/tei:figure/tei:graphic/@url}" data-lightbox='envelope'>
                    <img src='{$kiln:content-path}/images/{$root/@xml:id}/{$image_list//tei:item[last()]/tei:figure/tei:graphic/@url}'/>
					</a>
                </xsl:when>
                <xsl:otherwise>
                    <p>No envelope available</p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </section>
    <xsl:apply-templates select="tei:sourceDesc"/>
     <xsl:apply-templates select="tei:revisionDesc"/>
      <section>
        <h2 class="title" data-section-title="">
          <small><a href="#">Other formats</a></small>
        </h2>
        <div class="content" data-section-content="">
          <ul class="no-bullet">
            <li>
              <a href="{../@xml:id}.xml">
                <abbr title="Text Encoding for Interchange">TEI</abbr>
                <xsl:text> source</xsl:text>
              </a>
            </li>
          </ul>
        </div>
      </section>
    </div>
  </xsl:template>

  <xsl:template match="tei:change">
    <li>
      <xsl:apply-templates select="@when" />
      <!-- A tei:change may contain so much markup that it is best to
           use the base templates to render it. -->
      <xsl:apply-templates />
      <xsl:apply-templates select="@who" />
    </li>
  </xsl:template>

  <xsl:template match="tei:encodingDesc">
    <section>
      <h2 class="title" data-section-title="">
        <small><a href="#">Encoding description</a></small>
      </h2>
      <div class="content" data-section-content="">
        <xsl:apply-templates />
      </div>
    </section>
  </xsl:template>

  <xsl:template match="tei:msDesc">
    <xsl:apply-templates select="tei:msIdentifier" />
  </xsl:template>


      <xsl:template match="tei:publisher">
        <p>
          <strong>Publisher:</strong>
          <xsl:text> </xsl:text>
          <xsl:apply-templates />
        </p>
      </xsl:template>

      <xsl:template match="tei:pubPlace">
        <p>
          <strong>Place of publication:</strong>
          <xsl:text> </xsl:text>
          <xsl:apply-templates />
        </p>
      </xsl:template>



  <xsl:template match="tei:revisionDesc">
    <section>
      <h2 class="title" data-section-title="">
        <small><a href="#">File changelog</a></small>
      </h2>
      <div class="content" data-section-content="">
        <ul class="no-bullet">
          <xsl:apply-templates />
        </ul>
      </div>
    </section>
  </xsl:template>

  <xsl:template match="tei:sourceDesc">
    <section>
      <h2 class="title" data-section-title="">
        <small><a href="#">Source document details</a></small>
      </h2>
      <div class="content" data-section-content="">
        <xsl:apply-templates />
      </div>
    </section>
  </xsl:template>

  <xsl:template match="tei:change/@when">
    <strong>
      <xsl:value-of select="." />
      <xsl:text>:</xsl:text>
    </strong>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="tei:change/@who">
    <xsl:text> [</xsl:text>
    <xsl:choose>
      <xsl:when test="starts-with(., '#')">
        <xsl:variable name="who-id" select="substring(., 2)" />
        <xsl:apply-templates select="ancestor::tei:teiHeader//*[@xml:id=$who-id]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>] </xsl:text>
  </xsl:template>

</xsl:stylesheet>
