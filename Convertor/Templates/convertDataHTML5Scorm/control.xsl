<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
  extension-element-prefixes="redirect">
  
  <xsl:output method="html" version="4.0"  omit-xml-declaration="yes" doctype-public="html"   encoding="UTF-8" indent="yes"/>
  <!--определяет формат для создания дополнительного файла (question.js)-->
  <xsl:output method="text" name="textFormat"/>
  <!--Имя папки для медиафайлов курса-->
   <xsl:param name="mediaFolderName" />
  <!--Имя папки для медиафайлов теста-->
  <xsl:param name="currentFolderName" />
  <!--относительный путь для медиафайлов теста-->
  <xsl:param name="mediaPath" select="concat($mediaFolderName,concat('/',$currentFolderName,'/'))"/>
     
  <xsl:template match="test">
    <html lang="en">
      <head>
        <!--Код HTML (будет формироваться без изменений)-->
        <xsl:text disable-output-escaping="yes">
        <![CDATA[
          <meta charset="utf-8" ></meta>        
          <meta name="description" content=""/>
          <meta name="author" content="RPTS"/>
          <link href="themeplate/tests/templates/main.css" rel="stylesheet" type="text/css"></link>
          <link href="themeplate/tests/templates/frameViewStyle.css" rel="stylesheet" type="text/css"></link>
          <!--[if lte IE 8]> <html class="ie8_all" lang="en"> <![endif]-->
        ]]></xsl:text> 
        <title>
          <xsl:value-of select="title"/><!--Заголовок теста-->
        </title>
      </head>
      <body>
        <xsl:text disable-output-escaping="yes">
        <![CDATA[
          <form id="navFrm">
            <input type="button" id="btnForvd" onclick="GoNextPage();" />
          </form>         
         <div id="resDiv" style="display:none"></div>          
          <form id="testForm" onsubmit="return  testManager.checkAnswer();">
          
          </form>
          <center id="mess"></center>
        <script type="text/javascript" src="themeplate/tests/js/cripto.js"></script>
        <script type="text/javascript" src="themeplate/tests/js/ScormAdapter.js"></script>
       <script type="text/javascript" src="themeplate/tests/js/ApiWrapper.js"></script>
        <script type="text/javascript" src="themeplate/tests/js/SCOFunctions.js"></script>
        <script type="text/javascript" src="themeplate/tests/js/SCOTestFunc.js"></script>
        <script type="text/javascript" src="]]></xsl:text>
        <xsl:value-of select="$mediaPath"/><!--Путь к файлу с вопросами относительно страницы теста-->
        <!--Код HTML (будет формироваться без изменений)-->
        <xsl:text disable-output-escaping="yes"><![CDATA[questions.js"></script>
        <script type="text/javascript">
            window.onload = function () { loadPage(); };
            window.onunload = function () { unloadPage(); };        
        </script>
      ]]></xsl:text>
      </body>
    </html>
    <!--Формирование файла с вопросами теста questions.js (относительный путь задается в коде c#),
    который создает экземпляры вариантов ответов и вопросов для дальнейшего взаимодействия с функциями js-->
    <xsl:result-document    href="questions.js" format="textFormat">
      <xsl:text disable-output-escaping="yes">
        <![CDATA[
          var GetAllTests=function()
          {
	          var tests=new Array();
	          var test;	
	          var ans=new Array();      		
	          var pic=new Array();
        ]]>
    </xsl:text>
        <xsl:apply-templates select="questions" />
    return tests;
    }

  </xsl:result-document>
  </xsl:template>

  <!--Вопросы теста-->
  <xsl:template match="question">   
    <xsl:variable name="nt" select="position()-1"/>
    ans = new Array();
    pic=new Array();  
    <xsl:apply-templates select="QuestionAttributes/PictureItem"/>   
    <!--Если вопрос-выбор из нескольких вариантов-->
    <xsl:if test="@type='choice'"> 
      <xsl:apply-templates select="options/option">
        <xsl:with-param name="answerClassName" select="'CheckedAns'"/>
      </xsl:apply-templates>
      test=new CheckedTest(ans,"<xsl:value-of select="identifer"/>","<xsl:value-of select="title/text"/>",new Vector4(<xsl:value-of select="title/attributes/location/@X"/>,<xsl:value-of select="title/attributes/location/@Y"/>,<xsl:value-of select="title/attributes/size/@Width"/>,<xsl:value-of select="title/attributes/size/@Height"/>),pic);
      test.correct=new Array( 
        <xsl:for-each select="options/option[@correct='True']">
          "<xsl:value-of select="@hash"/>" <xsl:if test="not(position()=last())">,</xsl:if>
        </xsl:for-each>  
      );     
    </xsl:if>
    <!--Если вопрос-последовательность-->
    <xsl:if test="@type='sequence'">      
      <xsl:apply-templates select="options/option">
        <xsl:with-param name="answerClassName" select="'AnswerSeq'"/>
      </xsl:apply-templates>
      test=new TestSeq(ans,"<xsl:value-of select="identifer"/>","<xsl:value-of select="title/text"/>",new Vector4(<xsl:value-of select="title/attributes/location/@X"/>,<xsl:value-of select="title/attributes/location/@Y"/>,<xsl:value-of select="title/attributes/size/@Width"/>,<xsl:value-of select="title/attributes/size/@Height"/>),pic);
      test.correct=new Array(
      <xsl:for-each select="options/option">
        <xsl:sort select="@order"/>       
          "<xsl:value-of select="@hash"/>" <xsl:if test="not(position()=last())">,</xsl:if>       
        </xsl:for-each>
      
      );
    </xsl:if>
    tests[<xsl:value-of select="$nt"/>]=test;
  </xsl:template>
  
  <xsl:template match="PictureItem">    
    <xsl:variable name="np" select="position()-1"/>
    <!--вызывается для получения только имени файла картинки (без пути)-->
    <xsl:variable name="picFileName">
      <xsl:call-template name="reverse">
        <xsl:with-param name="MainString" select="fileName"/>
        <xsl:with-param name="input" select="fileName"/>
      </xsl:call-template>
    </xsl:variable>
   
      
    
    pic[<xsl:value-of select="$np"/>]={pic:"<xsl:value-of select="concat($mediaPath,$picFileName)"/>",vec4:new Vector4(<xsl:value-of select="location/@X"/>,<xsl:value-of select="location/@Y"/>,<xsl:value-of select="size/@Width"/>,<xsl:value-of select="size/@Height"/>)};
  </xsl:template>
  
  <xsl:template match="option">
    <xsl:param name="answerClassName"/>
    <xsl:variable name="n" select="position()-1"/>       
    
    ans[<xsl:value-of select="$n"/>]=new <xsl:value-of select="$answerClassName"/>("<xsl:value-of select="@id"/>","<xsl:value-of select="text"/>",new Vector4(<xsl:value-of select="attributes/location/@X"/>,<xsl:value-of select="attributes/location/@Y"/>,<xsl:value-of select="attributes/size/@Width"/>,<xsl:value-of select="attributes/size/@Height"/>));
   </xsl:template>

  <!--шаблон для получения имени файла (без пути) -->
  <xsl:template  name="reverse">
    <xsl:param name="MainString">12345</xsl:param>
    <xsl:param name="input">12345</xsl:param>
    <xsl:param name="size" select="string-length($input)"/>
    <xsl:param name="LastSlashPos" select="string-length($MainString)-$size"/>
    <xsl:choose>
      <xsl:when  test="$size &lt; 1">
        <xsl:value-of select="$MainString"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="PathChar" select="substring($input,$size,1)"/>
        <xsl:if test="$PathChar='\'">
          <xsl:value-of select="substring($MainString,$size+1,string-length($MainString))"/>
        </xsl:if>
        <xsl:if test="$PathChar!='\'">
          <!--  рекусивный вызов  -->
          <xsl:call-template name="reverse">
            <xsl:with-param name="MainString" select="$MainString"/>
            <xsl:with-param name="input" select="$input"/>
            <xsl:with-param name="size" select="$size - 1"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>
  <!--для замены переноса строк </br> (в данный момент не используется, т.к. реализован кодом c#!!!)-->
  <xsl:template name="replace">
    <xsl:param name="input"/>
    <xsl:param name="from"/>
    <xsl:choose>
      <xsl:when test="contains($input, $from)">
        <xsl:value-of select="substring-before($input, $from)"/>
        <br/>
        <xsl:call-template name="replace">
          <xsl:with-param name="input" select="substring-after($input, $from)"/>
          <xsl:with-param name="from" select="$from"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$input"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
