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

    
    <!-- HTML 5 doctype -->
    <xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes" include-content-type="no"/>
    <xsl:param name="north">
        <type>region</type>
    </xsl:param>
    <xsl:param name="west">
        <type>region</type>
    </xsl:param>
    <xsl:param name="center">
        <type>region</type>
    </xsl:param>
    <xsl:param name="east">
        <type>region</type>
    </xsl:param>
    <xsl:param name="south">
        <type>region</type>
    </xsl:param>
    
    <!-- Select template based on current device -->
    <xsl:template match="/">
            <xsl:text disable-output-escaping="yes">
      &lt;!DOCTYPE html&gt;
    </xsl:text>
            <html lang="{$stk:language}">
                <!-- version="HTML+RDFa 1.1" -->
                <head>
                    <title>
                        <xsl:value-of select="stk:menu.menuitem-name($stk:current-resource)"/>
                        <xsl:value-of select="concat(' - ', $stk:site-name)"/>
                    </title>
                    <xsl:call-template name="stk:head.create-metadata"/>
                    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap-combined.min.css" rel="stylesheet"/>
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
    
    <!-- Desktop template -->
    <xsl:template name="body">
       
            <body>
                    <!--<xsl:call-template name="stk:menu.render">
                        <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems"/>
                        <xsl:with-param name="levels" select="1"/>
                        <xsl:with-param name="list-class" select="'menu horizontal main level1'" />
                    </xsl:call-template>-->
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
                    <h3 class="muted">Responsive Templating Kit</h3>
                </div>
                </div>
                
             
               
                <div class="container">
                    <!-- Renders all regions defined in config -->
                    <xsl:call-template name="region.renderall"/>
                </div>
                <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
                <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script>
            </body>
      
    </xsl:template>
</xsl:stylesheet>
