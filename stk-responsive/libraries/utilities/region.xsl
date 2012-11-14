<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns:stk="http://www.enonic.com/cms/xslt/stk" xmlns:portal="http://www.enonic.com/cms/xslt/portal" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:import href="/stk-responsive/libraries/utilities/stk-variables.xsl"/>
    
    <!-- 
      Major rebuild of Enonic stk / packages region.xsl
      Problem 1:
      Could not wrap a group of regions in a html element for creating a row.
      Solved by wrapping one or more <region> inside <area> nodes in the config.xml. For-each <area> - create wrapper (row).         
      Problem 2:
      Inline CSS and messy region width calculation.
   -->
    
    <xsl:variable name="active-regions" as="element()*">
        <xsl:copy-of select="/result/context/page/regions/region[count(windows/window) gt 0]"/>
    </xsl:variable>
    
    <xsl:variable name="gridsystem-columns" as="xs:integer" select="$stk:config-device-class/gridsystem/columns"/>
    <xsl:variable name="gridsystem-colwidth" as="xs:integer" select="$stk:config-device-class/gridsystem/columnwidth"/>
    <xsl:variable name="gridsystem-colgutter" as="xs:integer" select="$stk:config-device-class/gridsystem/gutterwidth"/>
    
    <xsl:template name="region.renderall">
        <!-- Apply template på hver <area> som har <region> (child) hvor det er satt inn portlets -->
        <xsl:apply-templates select="$stk:config-device-class/layout/area[region[index-of($active-regions/name, @name) castable as xs:integer]]"/>
    </xsl:template>
    
    <xsl:template match="area"> 
        <xsl:variable name="active-regions-in-current-area">
            <xsl:copy-of select="region[index-of($active-regions/name, @name) castable as xs:integer]"/>
        </xsl:variable>
        
        <xsl:variable name="area" select="."/>
        <div class="row"> 
            <xsl:for-each select="$active-regions-in-current-area/region">
                <!-- Doc: Flexible columns. Setting column width (1-12) which is used for grid html classes and calculating image max width-->
                <xsl:variable as="xs:integer" name="columns">                   
                    <xsl:choose>
                        <xsl:when test="$area/@dynamic = 'true' and (@name = 'west' or @name = 'center' or @name = 'east')">
                            <!-- Area region width IS dynamic-->
                            <xsl:choose>
                                <xsl:when test="@name = 'west'">
                                    <xsl:choose>
                                        <xsl:when test="../region[@name = 'east'] and not(../region[@name = 'center'])">
                                            6
                                        </xsl:when>
                                        <xsl:otherwise>
                                            4
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="@name = 'east'">
                                    <xsl:choose>
                                        <xsl:when test="../region[@name = 'west'] and not(../region[@name = 'center'])">
                                            6
                                        </xsl:when>
                                        <xsl:otherwise>
                                            4
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="@name = 'center'">
                                    <xsl:choose>
                                        <xsl:when test="../region[@name = 'east'] and ../region[@name = 'west']">
                                            6
                                        </xsl:when>
                                        <xsl:when test="../region[@name = 'east'] or ../region[@name = 'west']">
                                            8
                                        </xsl:when>
                                        <xsl:otherwise>
                                            12
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="count($area/region) gt 1 and $gridsystem-columns gt 1">
                            <!-- Multiple regions in area. NOT dynamic. -->
                            <xsl:value-of select="floor($gridsystem-columns div count(../region))"/>
                            <!-- Nbr of total gridsystem cols divided by nbr of regions in current area-->
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- Area is NOT dynamic -->
                            <xsl:value-of select="$gridsystem-columns"/>
                        </xsl:otherwise>
                    </xsl:choose>                                
                </xsl:variable>
                <xsl:variable as="xs:integer" name="region-width" select="($columns * $gridsystem-colwidth) + ($gridsystem-colgutter * ($columns - 1))"/>
                <!-- $region-width: used for image max width only. Pixel value.
                  Debug: id="pagesection-{@name}" data-region-width="{$region-width}" data-calculated-nbr-of-columns="{$columns}" data-grid-columns="{$gridsystem-columns}" data-grid-gutter="{$gridsystem-colgutter}" data-grid-colwidth="{$gridsystem-colwidth}" -->
                <div class="span{$columns}">
                    <xsl:call-template name="region.render">
                        <xsl:with-param name="region" select="current()/@name"/>
                        <xsl:with-param name="parameters" as="xs:anyAtomicType*">
                            <xsl:sequence select="'_config-region-width', xs:integer($region-width)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <!-- Region template -->
    <!-- Create portlet placeholder for region -->
    <xsl:template name="region.render">
        <xsl:param name="region"/>
        <xsl:param name="parameters" as="xs:anyAtomicType*"/>
        <xsl:for-each select="$stk:rendered-page/regions/region[name = $region]/windows/window">
            <xsl:value-of select="portal:createWindowPlaceholder(@key, $parameters)"/>
        </xsl:for-each>
    </xsl:template>  
</xsl:stylesheet>
