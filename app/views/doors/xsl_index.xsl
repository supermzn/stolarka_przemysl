<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">

<h1>Oto nasze drzwi</h1>
<div style='width: 800px;'>
  <div id="map" style='width: 800px; height: 400px;'></div>
</div>



<div>
	<xsl:for-each select="//door">
		<div class="well well-sm">
			<xsl:element name="a">
			    <xsl:attribute name="href">
			        doors/<xsl:value-of select="id"/>
			    </xsl:attribute>
    			<u><xsl:value-of select="title" /></u>
			</xsl:element>
		</div>
	</xsl:for-each>
</div>

</xsl:template>
</xsl:stylesheet>