<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:portal="http://www.enonic.com/cms/xslt/portal" 
   xmlns:stk="http://www.enonic.com/cms/xslt/stk">
  
   <xsl:import href="/stk-responsive/libraries/utilities/stk-variables.xsl"/>
   <xsl:import href="/stk-responsive/libraries/utilities/system.xsl"/>
   
   <!-- Metadata template -->
   <xsl:template name="stk:head.create-metadata">
      <xsl:param name="description" as="xs:string?"/>
      <xsl:param name="keywords" as="xs:string?"/>
      
      <xsl:variable name="stk:head.meta-generator" select="stk:system.get-config-param('meta-generator', $stk:path)" as="element()?"/>
      <xsl:variable name="stk:head.meta-author" select="stk:system.get-config-param('meta-author', $stk:path)" as="element()?"/>      
      <xsl:variable name="stk:head.meta-google-site-verification" select="stk:system.get-config-param('google-site-verification', $stk:path)" as="element()?"/>
      <xsl:variable name="stk:head.meta-favicon" select="stk:system.get-config-param('meta-favicon', $stk:path)" as="element()?"/>
      
      <xsl:variable name="stk:canonical-url">
         <xsl:choose>
            <xsl:when test="/result/context/querystring/parameter[@name = 'key']">
               <xsl:value-of select="portal:createContentUrl(/result/context/querystring/parameter[@name = 'key'],())"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="portal:createPageUrl(portal:getPageKey(),())"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
            
      <xsl:variable name="stk:head.meta-description">
         <xsl:choose>
            <xsl:when test="/result/contents/content/contentdata/meta-description != ''">
               <xsl:value-of select="/result/contents/content/contentdata/meta-description"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$stk:current-resource/description"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="stk:head.meta-keywords">
         <xsl:choose>
            <xsl:when test="/result/contents/content/contentdata/meta-keywords != ''">
               <xsl:value-of select="/result/contents/content/contentdata/meta-keywords"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$stk:current-resource/keywords"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="stk:head.meta-content-key">
         <xsl:value-of select="/result/context/resource[@type = 'content']/@key"/>
      </xsl:variable>
      <xsl:variable name="stk:head.meta-content-type">
         <xsl:value-of select="/result/context/resource[@type = 'content']/type"/>
      </xsl:variable>      
      
      <meta charset="utf-8"/>
      
      <xsl:if test="normalize-space($stk:head.meta-generator)">
         <meta name="generator" content="{$stk:head.meta-generator}"/>
      </xsl:if>
      
      <xsl:if test="normalize-space($stk:head.meta-author)">
         <meta name="author" content="{$stk:head.meta-author}"/>
      </xsl:if>
      
      <xsl:if test="normalize-space($description) or normalize-space($stk:head.meta-description)">
         <meta name="description" content="{if (normalize-space($description)) then $description else $stk:head.meta-description}"/>
      </xsl:if>
      
      <xsl:if test="normalize-space($keywords) or normalize-space($stk:head.meta-keywords)">
         <meta name="keywords" content="{if (normalize-space($keywords)) then $keywords else $stk:head.meta-keywords}"/>
      </xsl:if>

      <xsl:if test="normalize-space($stk:head.meta-google-site-verification)">
         <meta name="google-site-verification" content="{$stk:head.meta-google-site-verification}"/>
      </xsl:if>
      
     
      <meta content="width=device-width, initial-scale=1.0" name="viewport" />
      <meta name="apple-mobile-web-app-capable" content="yes" />
      
      <xsl:if test="$stk:head.meta-favicon">
         <link rel="shortcut icon" type="image/x-icon" href="{portal:createResourceUrl($stk:head.meta-favicon)}"/>
      </xsl:if>
   
      
      <!-- for Google Search Appliance -->
      <xsl:if test="normalize-space($stk:head.meta-content-key)">
         <meta name="_key" content="{$stk:head.meta-content-key}"/>
      </xsl:if>
      <xsl:if test="normalize-space($stk:head.meta-content-type)">
         <meta name="_cty" content="{$stk:head.meta-content-type}"/>
      </xsl:if>
      
      <xsl:if test="$stk:canonical-url">
         <link rel="canonical" href="{$stk:canonical-url}"/>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
