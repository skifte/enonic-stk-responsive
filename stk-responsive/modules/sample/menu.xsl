<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">


    <xsl:import href="/stk-responsive/libraries/utilities/menu.xsl"/>
    <xsl:template match="/">
        <hr/>
        <nav class="pagination-centered">
                <xsl:for-each select="/result/menu/menuitems/menuitem">
                    <a href="{portal:createPageUrl(@key,())}" class="btn btn-large">
                        <xsl:if test="@active = 'true'">
                            <xsl:attribute name="class" select="'btn btn-primary btn-large'"/>
                        </xsl:if>
                        <xsl:value-of select="stk:menu.menuitem-name(current())"/>
                    </a>
                    <xsl:text> </xsl:text>
                </xsl:for-each>
        </nav>
        
    </xsl:template>  
    <xsl:function name="stk:menu.menuitem-name" as="xs:string">
        <xsl:param name="menuitem" as="element()?"/>
        <xsl:value-of select="if (normalize-space($menuitem/display-name)) then $menuitem/display-name else if (normalize-space($menuitem/alternative-name)) then $menuitem/alternative-name else $menuitem/name"/>
    </xsl:function>
</xsl:stylesheet>
            
    
    