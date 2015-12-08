<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="html" version="4.0"  omit-xml-declaration="yes" doctype-public="html"   encoding="UTF-8" indent="yes"/>
  <xsl:output method="html" version="4.0"  omit-xml-declaration="yes" doctype-public="html"   encoding="UTF-8" indent="yes" name="htmlFormat"  />
  <!--Параметры передаются во время конвертации-->
  <xsl:param name="picFolder"/>  <!--Название папки с медиа-файлами конкретной темы-->
  <xsl:param name="mediaPath"/>  <!--Название папки с медиа-файлами курса-->
  <xsl:param name="toolFolder"/> <!--Название папки с инструментами-->
 
  <!--Шаблон преобразования темы курса-->
  <xsl:template match="LearningItem">
    <!--Код HTML-->
    <html lang="en">
      <head>
        <meta charset="utf-8" ></meta>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="description" content=""/>
        <meta name="author" content="RPTS"/>
        <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina" />

        <title>
          <xsl:value-of select="title"/>      <!--заголовок страницы-->
        </title>
        
        <!--Код HTML (будет формироваться без изменений)-->
        <xsl:text disable-output-escaping="yes">
          <![CDATA[   <!-- Bootstrap core CSS -->
            <link href="themeplate/css/bootstrap.css" rel="stylesheet">
            <!--external css
            <link href="themeplate/font-awesome/css/font-awesome.css" rel="stylesheet" /> 
            <link rel="stylesheet" type="text/css" href="themeplate/lineicons/style.css">    -->    
            <!-- Custom styles for this template -->
            <link href="themeplate/css/style.css" rel="stylesheet">    
            <link href="themeplate/css/style-responsive.css" rel="stylesheet">
            <!--<link href="themeplate/css/video-default.css" rel="stylesheet">
            <script type="text/javascript" src="assets/js/player/swfobject.js"></script>-->
            <link href="themeplate/video/video-js.css" rel="stylesheet" type="text/css">     
            <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
            <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
            <![endif]-->
          ]]>
        </xsl:text>      
      </head>
      <body>
        <section id="container" >           
          <!--Код HTML (будет формироваться без изменений)-->
          <xsl:text disable-output-escaping="yes">
            <![CDATA[  
              <!--header start-->
              <header class="header black-bg">             
              ]]>
             </xsl:text>                      
                      <span class="logo"><b> <xsl:value-of select="title"/> </b></span><!--название темы-->
              <xsl:text disable-output-escaping="yes"> 
              <![CDATA[   
                </header>
 <div class="navbar-fixed-bottom " ></div>   ]]></xsl:text>           
      <!--список кадров (в левой части окна, может скрываться по нажатию кнопки)-->
        <aside>
          <div id="sidebar"  class="nav-collapse ">
            <ul class="sidebar-menu carousel-indicators" id="nav-accordion">
              <!--переменная - название выходного файла темы-->
              <xsl:variable name="fileSelf" select="concat(file,'.html')" />
              <!--для каждого кадра-->
              <xsl:for-each select="learningSteps/LearningStep">
                <xsl:variable name="n" select="position()-1"/>
                <xsl:choose>
                  <!--для первого кадра в списке-->
                  <xsl:when test="$n=0">
                    <li data-target="#frameCarousel" data-slide-to="{$n}"  class="mt active">
                      <a class="active" href="{$fileSelf}">
                        <span>
                          <xsl:value-of select="title"/>
                        </span>
                      </a>
                    </li>
                  </xsl:when>
                  <!--для остальных кадров в списке-->
                  <xsl:otherwise>
                    <li data-target="#frameCarousel" data-slide-to="{$n}"  class="mt ">
                      <a  href="{$fileSelf}">
                        <span>
                          <xsl:value-of select="title"/>
                        </span>
                      </a>
                    </li>
                 </xsl:otherwise>
               </xsl:choose> 
             </xsl:for-each>
           </ul>
         </div>
       </aside>       
       <!--main content start-->
       <section id="main-content">
            <div class="wrapper">
              <!--Навигационное меню (скрывает список кадров)-->
              <xsl:text disable-output-escaping="yes">
                          <![CDATA[
               <ul class="nav navmenu-nav">                  
                   <li style="margin-top:50px;">
                       <div id="btnList" class="sidebar-toggle-box">
                           <div class="fa  tooltips" data-placement="right"> <!--data-original-title="Показать/скрыть список кадров"--></div>
                       </div>
                   </li>  
               </ul>
              ]]></xsl:text>
              <section id="frameCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
                <!-- Слайды карусели -->
                <div class="carousel-inner" id="slids">
                  <xsl:for-each select="learningSteps/LearningStep">  
                    <xsl:variable name="n2" select="position()-1"/>
                    <xsl:choose>
                      <!--для первого кадра в списке-->
                      <xsl:when test="$n2=0">
                        <!-- Слайды создаются с помощью контейнера с классом item, внутри которого помещается содержимое слайда -->
                        <xsl:text disable-output-escaping="yes">
                          <![CDATA[       <div class="active item">
                            <div align="center" class="viewframe">]]></xsl:text>
                        <xsl:call-template name="setViewFrame">
                          <xsl:with-param name="picture" select="picture"/>
                          <xsl:with-param name="isImg" select="picture/@isSingle"/>
                        </xsl:call-template>
                        <xsl:text disable-output-escaping="yes">
                          <![CDATA[  
                                 </div>
                            <div style="clear:both"></div>
                            <div class="textframe ">]]></xsl:text>
                        <!--вывод кнопки инструментов кадра-->
                        <xsl:call-template name="viewTool">                         
                          <xsl:with-param name="step" select="." />
                          <!--путь к файлу инструментов-->
                          <xsl:with-param name="toolPath" select="concat($mediaPath,'/',$picFolder,'/',./locid,'.html')" />
                          <!--путь - имя файлы темы (для формирования обратной ссылки)-->
                          <xsl:with-param name="themePath" select="concat(../../file,'.html')" />
                        </xsl:call-template>                       

                        <xsl:text disable-output-escaping="yes">
                          <![CDATA[
                            <p id="<xsl:value-of select="warning/@flag"/><xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
                            <xsl:value-of select="warning/@text"/><!--текст предупреждения-->
                            <xsl:text disable-output-escaping="yes"><![CDATA[ </p>
                            <p>]]></xsl:text>                       
                        <xsl:value-of disable-output-escaping="yes"  select="text"/><!--текст кадра-->
                        <xsl:text disable-output-escaping="yes">
                        <![CDATA[        </p>
                          </div>
                        </div>]]></xsl:text>
                      </xsl:when>
                      <!--для остальных кадров в списке (отличие в названии классов)-->
                      <xsl:otherwise>
                        <xsl:text disable-output-escaping="yes">
                        <![CDATA[       <div class="item">
                      <div align="center" class="viewframe">]]></xsl:text>
                      <xsl:call-template name="setViewFrame">
                        <xsl:with-param name="picture" select="picture"/>
                        <xsl:with-param name="isImg" select="picture/@isSingle"/>
                      </xsl:call-template>
                      <xsl:text disable-output-escaping="yes">
                          <![CDATA[  
                                 </div>
                      <div style="clear:both"></div>
                      <div class="textframe ">]]></xsl:text>
                        <!--вывод кнопки инструментов кадра-->
                    <xsl:call-template name="viewTool">
                      <xsl:with-param name="step" select="." />
                      <!--путь к файлу инструментов-->
                      <xsl:with-param name="toolPath" select="concat($mediaPath,'/',$picFolder,'/',./locid,'.html')" />
                      <!--путь - имя файлы темы (для формирования обратной ссылки)-->
                      <xsl:with-param name="themePath" select="concat(../../file,'.html')" />
                    </xsl:call-template>

                    <xsl:text disable-output-escaping="yes">
                          <![CDATA[<p id="]]></xsl:text>
                      <xsl:value-of select="warning/@flag"/>
                      <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
                      <xsl:value-of select="warning/@text"/><!--текст предупреждения-->
                      <xsl:text disable-output-escaping="yes"><![CDATA[ </p>
                        <p>]]></xsl:text>
                      <xsl:value-of disable-output-escaping="yes"  select="text"/><!--текст кадра-->
                        <xsl:text disable-output-escaping="yes">
                      <![CDATA[        </p>
                          </div>
                        </div>]]></xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:for-each>
                </div>
                <xsl:text disable-output-escaping="yes">
        <![CDATA[
                <a class="left carousel-control" href="#frameCarousel" data-slide="prev">
                  <div class="prevfr"></div>
                </a>
                <a class="right carousel-control" href="#frameCarousel" data-slide="next">
                  <span class="nextfr"></span>
                </a>
]]></xsl:text>
              </section>
            </div>
          </section>
          <!--main content end-->
        </section>
         <!--подключаемые скрипты-->
        <xsl:text disable-output-escaping="yes">
        <![CDATA[ <script src="themeplate/js/jquery-1.8.3.min.js"></script>
          <script src="themeplate/js/bootstrap.min.js"></script>
          <script class="include" type="text/javascript" src="themeplate/js/jquery.dcjqaccordion.2.7.js"></script>
          <script src="themeplate/js/jquery.scrollTo.min.js"></script>
          <script src="themeplate/js/jquery.nicescroll.js" type="text/javascript"></script>
            <!-- <script src="themeplate/js/jquery.sparkline.js"></script>-->
            <script src="themeplate/video/video.js"></script>
          <!--common script for all pages-->
          <script src="themeplate/js/common-scripts.js"></script>
          <script type="text/javascript">
          // _V_.options.flash.swf = "video-js.swf";
          videojs.options.flash.swf = "themeplate/video/video-js.swf";  
        </script>]]>
    </xsl:text>
    </body>
    </html>  
  </xsl:template>

  <!--шаблон отображение медиа контента кадра-->
  <xsl:template name="setViewFrame">
    <xsl:param name="picture"/>
    <xsl:param name="isImg"/>
    <xsl:variable name="picName">
      <xsl:call-template name="get_file_withoutextension">
        <xsl:with-param name="file_name" select="$picture"/>
      </xsl:call-template>
    </xsl:variable>
    <!--путь к медиафайлу-->
    <xsl:variable name="videoFile" select="concat($mediaPath,concat('/',concat($picFolder,concat('/',$picName))))" />       
    <xsl:choose>
      <!--если ролик кадра темы состоит из одного кадра-->
      <xsl:when test="$isImg='true'">
        <xsl:text disable-output-escaping="yes">
        <![CDATA[
        <img class="imgFrame" alt="" src="]]></xsl:text><xsl:value-of select="concat($videoFile,'.jpg')"/><xsl:text disable-output-escaping="yes"><![CDATA["/>
          ]]></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <!--отображаем видео контент с картинкой-постером-->
        <xsl:text disable-output-escaping="yes">
        <![CDATA[
        <video  class="video-js vjs-default-skin" poster="]]></xsl:text>
      <xsl:value-of select="concat($videoFile,'.jpg')"/><xsl:text disable-output-escaping="yes"><![CDATA["
                                 controls preload="metadata" width="100%" height="100%" data-setup='{ }'>
        <source type="video/mp4" src="]]></xsl:text><xsl:value-of select="concat($videoFile,'.mp4')"/><xsl:text disable-output-escaping="yes"><![CDATA["/>
        <source type="video/webm" src="]]></xsl:text><xsl:value-of select="concat($videoFile,'.webm')"/><xsl:text disable-output-escaping="yes"><![CDATA["/>                                            
        </video>
]]>
    </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--шаблон отсечения расширения файла-->
  <xsl:template name="get_file_withoutextension">
    <xsl:param name="file_name"/>
    <xsl:choose>
      <xsl:when test="contains($file_name, '.')">
        <xsl:call-template name="get_file_withoutextension">
          <xsl:with-param name="file_name" select="substring-before($file_name, '.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$file_name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
<!--шаблон отображения инструментов кадра-->
  <xsl:template name="viewTool">
    <xsl:param name="step" />
    <xsl:param name="toolPath" />
    <xsl:param name="themePath" />
    <xsl:variable name="toolCount" select="count($step/Tools/Tool)"></xsl:variable>
    <!--если у кадра есть хотя бы один инструмент, создать кнопку открытия страницы с инструментами и саму страницу инструментов-->
    <xsl:if test="$toolCount &gt; 0">
      <xsl:text disable-output-escaping="yes"><![CDATA[
       <div class="navbar-fixed-right toolHref"><a href="]]></xsl:text><xsl:value-of select="$toolPath"/><xsl:text disable-output-escaping="yes"><![CDATA["
             onclick="return !window.open(this.href)"></a></div>]]></xsl:text>

      <!--Формирование файла со списком инструментов для каждого кадра (если есть инструменты) (относительный путь задается в коде c#)-->
      <xsl:result-document    href="{concat($step/locid,'.html')}" format="htmlFormat">
        <html lang="en">
          <head>
            <meta charset="utf-8" ></meta>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <meta name="description" content=""/>
            <meta name="author" content="RPTS"/>
            <meta name="keyword" content="Tools" />
            <title>
              Инструменты
            </title>

            <!--Код HTML (будет формироваться без изменений)-->
            <xsl:text disable-output-escaping="yes">
        <![CDATA[   <!-- Bootstrap core CSS -->
            <link href="../../themeplate/css/bootstrap.css" rel="stylesheet">
            <!--external css
            <link href="../../themeplate/font-awesome/css/font-awesome.css" rel="stylesheet" /> 
            <link rel="stylesheet" type="text/css" href="themeplate/lineicons/style.css">    -->    
            <!-- Custom styles for this template -->
            <link href="../../themeplate/css/style.css" rel="stylesheet">    
            <link href="../../themeplate/css/style-responsive.css" rel="stylesheet">
            <!--<link href="../../themeplate/css/video-default.css" rel="stylesheet">
            <script type="text/javascript" src="assets/js/player/swfobject.js"></script>-->
            <link href="../../themeplate/video/video-js.css" rel="stylesheet" type="text/css">     
            <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
            <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
            <![endif]-->
          ]]>
      </xsl:text>
          </head>
          <body>
            <section id="container" >
              <!--Код HTML (будет формироваться без изменений)-->
              <xsl:text disable-output-escaping="yes">
    <![CDATA[  
              <!--header start-->
              <header class="header black-bg">     
              <span class="logo">
                <b>
                  Инструметы
                </b>
              </span>                           
                </header>
 <div class="navbar-fixed-bottom " ></div>   ]]>
  </xsl:text>

              <!--header end-->
              <!--список инструментов-->
              <aside>
                <div id="sidebar"  class="nav-collapse ">
                  <ul class="sidebar-menu carousel-indicators" id="nav-accordion">
                    <!--переменная - название выходного файла темы-->
                    <xsl:variable name="fileSelf" select="concat(locid,'.html')" />
                    <!--для каждого кадра-->
                    <xsl:for-each select="Tools/Tool">
                      <xsl:variable name="n" select="position()-1"/>
                      <xsl:choose>
                        <!--для первого кадра в списке-->
                        <xsl:when test="$n=0">
                          <li data-target="#frameCarousel" data-slide-to="{$n}"  class="mt active">
                            <a class="active" href="{$fileSelf}">
                              <span>
                                <xsl:value-of select="@name"/>
                              </span>
                            </a>
                          </li>
                        </xsl:when>
                        <!--для остальных кадров в списке-->
                        <xsl:otherwise>
                          <li data-target="#frameCarousel" data-slide-to="{$n}"  class="mt ">
                            <a  href="{$fileSelf}">
                              <span>
                                <xsl:value-of select="@name"/>
                              </span>
                            </a>
                          </li>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                  </ul>
                </div>
              </aside>
              <!--main content start-->
              <section id="main-content">
                <div class="wrapper">
                  <!--Навигационное меню-->
                  <xsl:text disable-output-escaping="yes">
        <![CDATA[
               <ul class="nav navmenu-nav">
                  
                   <li style="margin-top:50px;">
                       <div id="btnList" class="sidebar-toggle-box">
                           <div class="fa  tooltips" data-placement="right"> </div>
                       </div>
                   </li>    
               </ul>
              ]]>
      </xsl:text>
                  <section id="frameCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
                    <!-- Слайды карусели -->
                    <div class="carousel-inner" id="slids">
                      <xsl:for-each select="Tools/Tool">
                        <xsl:variable name="n2" select="position()-1"/>
                        <xsl:variable name="picToolName" select="./@fileName">                          
                        </xsl:variable>
                        <xsl:choose>
                          <!--для первого инструмента в списке-->
                          <xsl:when test="$n2=0">
                            <!-- Слайды создаются с помощью контейнера с классом item, внутри которого помещается содержимое слайда -->
                            <xsl:text disable-output-escaping="yes">
                  <![CDATA[       <div class="active item">
                            <div align="center" class="viewframe">
                              <img class="imgTool" alt="" src="]]></xsl:text><xsl:value-of select="concat('../tool/',$picToolName)"/><xsl:text disable-output-escaping="yes"><![CDATA["/>
         
                                 </div>
                            <div style="clear:both"></div>
                            <div class="textframe ">]]>
                </xsl:text>
                            <xsl:text disable-output-escaping="yes">
                  <![CDATA[
                            <p>]]>
                </xsl:text>
                            <!--название инструмента-->
                            <xsl:value-of select="concat(./@name,'  ',./@marking)"/>
                            <xsl:text disable-output-escaping="yes">
                  <![CDATA[ </p>                           
                          </div>
                        </div>]]>
                </xsl:text>
                          </xsl:when>
                          <!--для остальных инструментов в списке (отличие в названии классов)-->
                          <xsl:otherwise>
                            <xsl:text disable-output-escaping="yes">
                  <![CDATA[       <div class="item">
                      <div align="center" class="viewframe"><img class="imgTool" alt="" src="]]></xsl:text><xsl:value-of select="concat('../tool/',$picToolName)"/><xsl:text disable-output-escaping="yes"><![CDATA["/>
         
                                 </div>
                            <div style="clear:both"></div>
                            <div class="textframe ">]]>
                </xsl:text>
                            <xsl:text disable-output-escaping="yes">
                  <![CDATA[
                            <p>]]>
                </xsl:text>
                            <!--название инструмента-->
                            <xsl:value-of select="concat(./@name,'  ',./@marking)"/>
                            <xsl:text disable-output-escaping="yes">
                  <![CDATA[ </p> 
                          </div>
                        </div>]]>
                </xsl:text>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </div>
                    <xsl:text disable-output-escaping="yes">
          <![CDATA[
                <a class="left carousel-control" href="#frameCarousel" data-slide="prev">
                  <div class="prevfr"></div>
                </a>
                <a class="right carousel-control" href="#frameCarousel" data-slide="next">
                  <span class="nextfr"></span>
                </a>
]]>
        </xsl:text>
                  </section>
                </div>
              </section>
              <!--main content end-->
            </section>
            <!--подключаемые скрипты-->
            <xsl:text disable-output-escaping="yes">
  <![CDATA[ <script src="../../themeplate/js/jquery-1.8.3.min.js"></script>
          <script src="../../themeplate/js/bootstrap.min.js"></script>
          <script class="include" type="text/javascript" src="../../themeplate/js/jquery.dcjqaccordion.2.7.js"></script>
          <script src="../../themeplate/js/jquery.scrollTo.min.js"></script>
          <script src="../../themeplate/js/jquery.nicescroll.js" type="text/javascript"></script>
          <script src="themeplate/js/ScormAdapter.js"></script>
          <script src="themeplate/js/ApiWrapper.js"></script>
            <!-- <script src="../../themeplate/js/jquery.sparkline.js"></script>-->
            <script src="../../themeplate/video/video.js"></script>
          <!--common script for all pages-->
          <script src="../../themeplate/js/common-scripts.js"></script>
          <script type="text/javascript">
         
          videojs.options.flash.swf = "../../themeplate/video/video-js.swf";  
        </script>]]>
</xsl:text>
          </body>
        </html>

      </xsl:result-document>
      
    </xsl:if>
  </xsl:template>  


</xsl:stylesheet>
