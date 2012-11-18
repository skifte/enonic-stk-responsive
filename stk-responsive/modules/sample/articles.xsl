<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
 
    <xsl:import href="/stk-responsive/libraries/utilities/stk-variables.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/html.xsl"/>
    
    <xsl:variable name="image-width">
        <xsl:choose>
            <xsl:when test="$stk:device-class = 'mobile'">
                <xsl:value-of select="$stk:gridsystem-colwidth"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="(4 * $stk:gridsystem-colwidth) + ($stk:gridsystem-colgutter * (4 - 1))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:template match="/">
        <div class="row-fluid">
            <div class="span12">
        <xsl:apply-templates select="/result/contents/content"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="content">      
        <article class="span4">
            <h2>
                <xsl:value-of select="title"/>
            </h2>
            <xsl:if test="contentdata/img/@key">
                <p>
           <xsl:call-template name="stk:image.create">
                <xsl:with-param name="image" select="/result/contents/relatedcontents/content[@key = current()/contentdata/img/@key]"/>
               <xsl:with-param name="region-width" select="$image-width"/>
            </xsl:call-template>
                </p>
            </xsl:if>
            <p>
                <a href="{portal:createContentUrl(@key,())}" title="{title}" class="btn">
                    View details »
                </a>
            </p>
        </article>
    </xsl:template>        
</xsl:stylesheet>
            
    
    