<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns="http://www.w3.org/1999/xhtml">  
  <xsl:output method="text" version="4.0"     encoding="UTF-8" indent="yes"/>
  <!--определяет идентификатор общих для всех элемнтов ресурсов-->
  <xsl:param name="commonFilesId" select="common_files"/> 
  <!--шаблон манифеста (не переносить на новую строку, нарушается определение версии xml)-->
  <xsl:template  match="Course"><xsl:text disable-output-escaping="yes"><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<manifest identifier="captivate_test_multires_seq_4" version="1" 
                xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2" 
                xmlns:adlcp="http://www.adlnet.org/xsd/adlcp_rootv1p2" 
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
                xsi:schemaLocation="http://www.imsproject.org/xsd/imscp_rootv1p1p2 imscp_rootv1p1p2.xsd http://www.imsglobal.org/xsd/imsmd_rootv1p2p1 imsmd_rootv1p2p1.xsd http://www.adlnet.org/xsd/adlcp_rootv1p2 adlcp_rootv1p2.xsd" 
                xmlns:imsss="http://www.imsglobal.org/xsd/imsss">
        
 <organizations default="mainCourse">
    <organization identifier="mainCourse" >
    <title>]]></xsl:text><xsl:value-of select="title"/><xsl:text disable-output-escaping="yes"><![CDATA[</title> ]]> </xsl:text>   
            <xsl:apply-templates select="LearningSection" />
            <xsl:apply-templates select="LearningItem"/>
            <xsl:apply-templates select="Test"/>
    <![CDATA[ </organization>
        </organizations> 
        <resources>]]>   
    <xsl:call-template name="scormResourses" >
      <xsl:with-param name="oner"  select="//LearningItem"/> <!--выборка всех тем курса независимо от уровня вложенности-->
    </xsl:call-template>
    <xsl:call-template name="scormResourses">
      <xsl:with-param name="oner" select="//Test"/> <!--выборка всех тестов курса независимо от уровня вложенности-->
    </xsl:call-template>
    <![CDATA[ 
    <resource identifier="common_files" type="webcontent" adlcp:scormType="asset">
    ]]>
      <xsl:apply-templates select="scorm/file" />    <!--выборка всех файлов из узла scorm, дочернего к узлу course-->
    <![CDATA[
    </resource>
        </resources>
       </manifest>]]>
         
      </xsl:template>
<!--шаблон представления секций-->
  <xsl:template match="LearningSection">
<![CDATA[<item  identifier="]]><xsl:value-of select="id"/><![CDATA[">
            <title>]]> <xsl:value-of select="title"/><!--заголовок секции--><![CDATA[</title>
            ]]>
      <xsl:apply-templates select="LearningSection"/>
      <xsl:apply-templates select="LearningItem"/>
      <xsl:apply-templates select="Test"/>
    <![CDATA[
        </item>  ]]> 
  </xsl:template>
  
  <!--шаблон представления темы-->
  <xsl:template match="LearningItem">
    <![CDATA[<item  identifier="]]><xsl:value-of select="id"/><![CDATA[" identifierref="]]><xsl:value-of select="file"/><![CDATA[">
              <title>]]><xsl:value-of select="title"/><![CDATA[</title>
            </item>  ]]>
  </xsl:template>

  <!--шаблон представления теста-->
   <xsl:template match="Test">
     <!--путь к странице теста-->
     <![CDATA[<item  identifier="]]><xsl:value-of select="id"/><![CDATA[" identifierref="]]><xsl:value-of select="file"/><![CDATA[">
                <title>]]><xsl:value-of select="title"/><![CDATA[ </title>
              </item>  ]]>
  </xsl:template>
  
  <!--шаблон для файлов-->
  <xsl:template match="scorm/file">    
    <![CDATA[<file href="]]><xsl:value-of select="."/><![CDATA["/>]]>   <!--точка означает выбор всего содержимого узла file-->
    </xsl:template>

  <!--шаблон ресурсов тем и тестов-->
  <xsl:template name="scormResourses">
    <xsl:param name="oner"/>
    <!--первый файл списка файлов - сам файл темы или теста-->
    <xsl:for-each select="$oner">     
    <![CDATA[<resource identifier="]]><xsl:value-of select="file"/><![CDATA[" type="webcontent" adlcp:scormType="sco" href="]]><xsl:value-of select="scorm/file[1]"/><![CDATA[">]]>
    <xsl:for-each select="scorm/file">
      <![CDATA[<file href="]]><xsl:value-of select="."/><![CDATA["/>]]>
    </xsl:for-each>
    <![CDATA[<dependency identifierref="common_files"/>
    </resource>]]>
    </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
