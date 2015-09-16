<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">

<!-- część kodu (js/ruby) musiały zostać przeklejone jako czysty tekst  -->
<xsl:text disable-output-escaping="yes">
<![CDATA[
<script src="//maps.google.com/maps/api/js?v=3.13&amp;sensor=false&amp;libraries=geometry" type="text/javascript"></script>
<script src='//google-maps-utility-library-v3.googlecode.com/svn/tags/markerclustererplus/2.0.14/src/markerclusterer_packed.js' type='text/javascript'></script>
<% if current_user %>
	<%= link_to "Dodaj nowe drzwi", new_door_path, class: "btn btn-primary" %>
<% end %>
]]>
</xsl:text>



<h1>Oto nasze drzwi</h1>

<div style='width: 800px;'>
  <div id="map" style='width: 800px; height: 400px;'></div>
</div>

<xsl:text disable-output-escaping="yes">
<![CDATA[
<script type="text/javascript">
	handler = Gmaps.build('Google');
	handler.buildMap({
    provider: {},
    internal: {
      id: 'map'
    }
  },
  function(){
    markers = handler.addMarkers(<%= raw @hash.to_json %>);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  }
);
</script>
]]>
</xsl:text>

<div>
	<xsl:for-each select="//door">
		<div class="well well-sm">
			<xsl:element name="a">
			    <xsl:attribute name="href">/doors/<xsl:value-of select="id"/>      
			    </xsl:attribute>
    			<u><xsl:value-of select="title" /></u>
			</xsl:element>
		</div>
	</xsl:for-each>
</div>

	</xsl:template>
</xsl:stylesheet>