<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/stk-responsive/libraries/utilities/stk-variables.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/region.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/head.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/accessibility.xsl"/>    
    <xsl:import href="/stk-responsive/libraries/utilities/menu.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/google.xsl"/>    
    <xsl:import href="/stk-responsive/libraries/utilities/system.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/menu.xsl"/>
    
    <xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes" include-content-type="no"/>
    <xsl:param name="region-north">
        <type>region</type>
    </xsl:param>
    <xsl:param name="region-west">
        <type>region</type>
    </xsl:param>
    <xsl:param name="region-center">
        <type>region</type>
    </xsl:param>
    <xsl:param name="region-east">
        <type>region</type>
    </xsl:param>
    <xsl:param name="region-south">
        <type>region</type>
    </xsl:param>
    <xsl:param name="scripts-region">
        <type>region</type>
    </xsl:param>
    
    <xsl:template match="/">
            <xsl:text disable-output-escaping="yes">
      &lt;!DOCTYPE html&gt;
    </xsl:text>
            <html lang="{$stk:language}">
                <head>
                    <title>
                        <xsl:value-of select="stk:menu.menuitem-name($stk:current-resource)"/>
                        <xsl:value-of select="concat(' - ', $stk:site-name)"/>
                    </title>
                    <xsl:call-template name="stk:head.create-metadata"/>
                    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap-combined.min.css" rel="stylesheet"/>
                    <link href="{portal:createResourceUrl('/_public/stk-responsive/styles/css/stk-styles.css')}" rel="stylesheet"/>
                    <xsl:call-template name="stk:google.analytics"/>
                </head>
                <!-- Run config check to make sure everything is OK -->
                <xsl:variable name="config-status" select="stk:system.check-config()"/>
                <xsl:choose>
                    <xsl:when test="$config-status/node()">
                        <xsl:copy-of select="$config-status"/>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:call-template name="body"/>
                    </xsl:otherwise>
                </xsl:choose>
            </html>
            
   
    </xsl:template>
    
    <xsl:template name="body">
            <body>             
                <div class="container">
                <div class="masthead">
                    <ul class="nav nav-pills pull-right">
                        <li>
                            <xsl:if test="$stk:device-class = 'mobile'">
                                <xsl:attribute name="class" select="'active'"/>
                            </xsl:if>
                            <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'mobile', 'lifetime', 'session'))}" rel="nofollow">
                                <xsl:text>Mobile</xsl:text>
                            </a>
                        </li>
                        <li>
                            <xsl:if test="$stk:device-class = 'tablet'">
                                <xsl:attribute name="class" select="'active'"/>
                            </xsl:if>
                            <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'tablet', 'lifetime', 'session'))}" rel="nofollow">
                                <xsl:text>Tablet</xsl:text>
                            </a>
                        </li>
                        <li>
                            <xsl:if test="$stk:device-class = 'desktop'">
                                <xsl:attribute name="class" select="'active'"/>
                            </xsl:if>
                            <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'desktop', 'lifetime', 'session'))}" rel="nofollow">
                                <xsl:text>Desktop</xsl:text>
                            </a>
                        </li>
                    </ul>
                </div>
                </div>
                
                <div class="container">
                    <!-- Renders all regions defined in config -->
                    <xsl:call-template name="region.renderall"/>
                </div>
                <footer class="footer">
                    <div class="container">
                        <p>Responsive demo created by <a href="https://github.com/skifte" rel="external">Anders Skifte</a>. Based on the <a href="http://www.enonic.com/en/docs/stk" rel="external">Enonic STK</a>.</p>
                    </div>
                </footer>
                <xsl:if test="$scripts-region != ''">
                    <!-- A region for page specific scripts. Recomended addon / plugin for compressing: https://github.com/getas/enonic-resourcepacker-plugin -->
                    <xsl:call-template name="region.render">
                        <xsl:with-param name="region" select="'scripts-region'"/>
                    </xsl:call-template>
                </xsl:if>
            </body>
    </xsl:template>
</xsl:stylesheet>
