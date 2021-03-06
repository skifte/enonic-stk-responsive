<?xml version="1.0" encoding="UTF-8"?>

<!--
    **************************************************
    
    google.xsl
    version: ###VERSION-NUMBER-IS-INSERTED-HERE###
    
    **************************************************
-->

<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/stk-responsive/libraries/utilities/stk-variables.xsl"/>
    <xsl:import href="/stk-responsive/libraries/utilities/system.xsl"/>
    
    <xsl:template name="stk:google.analytics">
        <xsl:variable name="google-analytics-web-property-id" select="stk:system.get-config-param('google-analytics-web-property-id', $stk:path)" as="xs:string?"/>
        <xsl:variable name="google-analytics-domain-name" select="stk:system.get-config-param('google-analytics-domain-name', $stk:path)" as="xs:string?"/>
        <xsl:if test="normalize-space($google-analytics-web-property-id)">
            <script type="text/javascript">
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', '<xsl:value-of select="$google-analytics-web-property-id"/>']);
                <xsl:if test="normalize-space($google-analytics-domain-name)">_gaq.push(['_setDomainName', '<xsl:value-of select="$google-analytics-domain-name"/>']);</xsl:if>
                _gaq.push(['_trackPageview']);
                _gaq.push(['_trackPageLoadTime']);

                (function() {
                  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                })();
            </script>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>