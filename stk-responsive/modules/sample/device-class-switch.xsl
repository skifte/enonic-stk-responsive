<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
 
    <xsl:import href="/stk-responsive/libraries/utilities/stk-variables.xsl"/>
  
    
    <xsl:template match="/">
        <div class="well">Resolved device class is 
            <div class="btn-group">
                <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#">
                    <xsl:value-of select="$stk:device-class"/>
                    <xsl:text> </xsl:text>
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'mobile', 'lifetime', 'session'))}" class="change-device-class" rel="nofollow">
                            <xsl:text>mobile</xsl:text>
                        </a>
                    </li>
                    <li>
                        <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'tablet', 'lifetime', 'session'))}" class="change-device-class" rel="nofollow">
                            <xsl:text>tablet</xsl:text>
                        </a>
                        
                    </li>
                    
                    <li>
                        <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'desktop', 'lifetime', 'session'))}" class="change-device-class" rel="nofollow">
                            <xsl:text>desktop</xsl:text>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </xsl:template>   
</xsl:stylesheet>
            
    
    