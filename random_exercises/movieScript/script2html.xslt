<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/script">
<html>
<head><title><xsl:value-of select="header/title"/></title>
  <link href="https://fonts.googleapis.com/css?family=Roboto Mono" rel="stylesheet"/>
  <style><![CDATA[
body { font-family: "Roboto Mono", "Lucida Console", Monaco, monospace; 
       padding-left: 1em; padding-right: 1em; max-width: 5.5in; margin: auto; 
      font-size: 12pt; text-align: justify; }
header > h1 { text-align: center;   font-size: 150%; }
header > h2 { text-align: center;   font-size: 120%; }
nav > ol { font-size: 90%;  }
section.scene { margin-top: 3em; margin-bottom: 3em; }
nav > h1, section.scene > h1 { font-size: 120%; color: navy; }
section.scene > div.speaker { margin-top: 2em; margin-bottom: 2em; 
                              padding-left: 4em; padding-right: 4em; }
section.scene > div.speaker > h1 { font-size: 100%; text-align: center; margin-bottom: 0; } 
section.scene > div.speaker > h1 + p { margin-top: 0.25em; } 
section.scene > div.speaker > p.sdir { text-align: center; font-style: italic; } 
   ]]></style>
</head>
<body>
<header>
<h1> <xsl:value-of select="header/title" /> </h1>
<xsl:for-each select="header/author">
  <h2><xsl:value-of select="current()" /></h2>
</xsl:for-each> 
</header>
<nav>
  <h1>Contents</h1>
  <ol>
  <xsl:for-each select="scene">
     <li><a><xsl:attribute name="href">#sc<xsl:number/></xsl:attribute>
            <xsl:value-of select="title"/></a></li>
  </xsl:for-each> 
  </ol>
</nav>
<xsl:for-each select="scene">
  <section class="scene">
    <a><xsl:attribute name="name">sc<xsl:number/></xsl:attribute></a>
    <xsl:apply-templates />
  </section>
</xsl:for-each>
</body>
</html>
</xsl:template>

<xsl:template match="title">
   <h1><xsl:value-of select="current()"/></h1>
</xsl:template>

<xsl:template match="speaker">
  <div class="speaker">
     <xsl:apply-templates />
  </div>
</xsl:template>

<xsl:template match="desc">
  <xsl:apply-templates  />
</xsl:template>

<xsl:template match="name">
  <h1><xsl:value-of select="."/></h1>
</xsl:template>

<xsl:template match="sdir">
  <p class="sdir"><xsl:value-of select="."/></p>
</xsl:template>

<xsl:template match="p">
  <p><xsl:value-of select="." /></p>
</xsl:template>

</xsl:stylesheet>
