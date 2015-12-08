<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="html" version="4.0"  omit-xml-declaration="yes" doctype-public="html"   encoding="UTF-8" indent="yes"/>
  <!--Путь к станицам элементов курса относительно мтраницы структуры-->
  <xsl:param name="itemsPath"/>
  
  <xsl:template match="Course">   
    <html lang="en">
      <head>
        <meta charset="utf-8" ></meta>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="description" content=""/>
        <meta name="author" content="RPTS"/>
        <meta name="keyword" content="" />
        <title> <xsl:value-of select="title"/></title><!--заголовок страницы - название курса-->
        <link href="assets/themeplate/css/style.css" rel="stylesheet"/>

      </head>
      <body style="overflow:auto;">
        <div class="header black-bg">
          <span class="logo">
            <b>
              <xsl:value-of select="title"/><!--название курса-->
            </b>
          </span>
        </div>
        <div id="course-content">
          <ul>
            <xsl:apply-templates select="LearningSection" />
            <xsl:apply-templates select="LearningItem"/>
            <xsl:apply-templates select="Test"/>
          </ul>
        </div>
      </body>
    </html>  
      </xsl:template>
<!--шаблон представления секций-->
  <xsl:template match="LearningSection">
    <li class="course_section" >
      <xsl:value-of select="title"/><!--заголовок секции-->
      <ul>
      <xsl:apply-templates select="LearningSection"/>
      <xsl:apply-templates select="LearningItem"/>
      <xsl:apply-templates select="Test"/>
      </ul>
    </li>   
  </xsl:template>
  
  <!--шаблон представления темы-->
  <xsl:template match="LearningItem">
    <!--путь к странице темы-->
    <xsl:variable name="ifile" select="concat($itemsPath,concat('/',file,'.html'))" />
    <li class="course_theme">
      <!--ссылка на страницу темы-->
      <a  href="{$ifile}"><xsl:value-of select="title"/></a>      
    </li>
  </xsl:template>

  <!--шаблон представления теста-->
   <xsl:template match="Test">
     <!--путь к странице теста-->
    <xsl:variable name="ifile" select="concat($itemsPath,concat('/',file,'.html'))" />
    <li class="course_test">
      <!--ссылка на страницу теста-->
      <a  href="{$ifile}" ><xsl:value-of select="title"/></a>      
    </li>
  </xsl:template>
  
</xsl:stylesheet>
