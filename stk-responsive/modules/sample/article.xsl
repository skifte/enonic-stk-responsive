<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
 
    <xsl:import href="/stk-responsive/libraries/utilities/stk-variables.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/html.xsl"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="/result/contents/content[1]"/>
    </xsl:template>
    
    <xsl:template match="content">
        <article>
            <xsl:call-template name="stk:html.process">
                <xsl:with-param name="document" select="contentdata/text"/>
            </xsl:call-template>
        </article>
    </xsl:template>
    
            
</xsl:stylesheet>
            
    
    