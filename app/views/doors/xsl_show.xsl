<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/door">
<!-- część kodu (js/ruby) musiały zostać przeklejone jako czysty tekst  -->
	<xsl:text disable-output-escaping="yes">
		<![CDATA[
			<script src="//maps.google.com/maps/api/js?v=3.13&amp;sensor=false&amp;libraries=geometry" type="text/javascript"></script>
			<script src='//google-maps-utility-library-v3.googlecode.com/svn/tags/markerclustererplus/2.0.14/src/markerclusterer_packed.js' type='text/javascript'></script>
		]]>
	</xsl:text>
<div>
<div id="door_description">
	<div class="row">
		<div class="col-md-6">
			<h1><xsl:value-of select="title"/></h1>
			<h3><xsl:value-of select="address" /></h3>
			<h4>
				<b>Wspolrzedne: </b>Long: <xsl:value-of select="longitude"/> Lat: <xsl:value-of select="latitude"/>
			</h4>

			<!-- W galerii domyślnie mają się pojawić inne ujęcia drzwi, ale tego jeszcze nie ma, więc są poglądowe obrazki -->
			<div class="well well-sm">
			  <button id="prev">Wstecz</button>
			  <button id="next">Dalej</button>
				<ul class="slider">
				 <li>
				  <img src="http://loremflickr.com/320/240/door/?random=1" />
				 </li>
				 <li>
				   <img src="http://loremflickr.com/320/240/door/?random=2" />
				 </li>
				 <li>
				   <img src="http://loremflickr.com/320/240/door/?random=3" />
				 </li>
				 <li>
				   <img src="http://loremflickr.com/320/240/door/?random=4" />
				 </li>
				</ul>
			</div>
		</div>
		<div class="col-md-6">
			<img>
				<xsl:attribute name="src">
					<xsl:value-of select="image"/>
				</xsl:attribute>
				<xsl:attribute name="height">60%</xsl:attribute>
				<xsl:attribute name="width">60%</xsl:attribute>
			</img>
		</div>
	</div>
	<br/>
	<div class="row well">
		<div class="col-md-7">
			<p>
				<xsl:value-of select="description"/>
			</p>
		</div>
		<div class="col-md-5">
							<!-- mapa -->
			  <div id="map" style='width: 100%; height: 400px;'></div>

		</div>
	</div>
</div>
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
    // markers are indexed [0..N], but doors have their's own ids
    // need to center on current door, then focus on specified marker
    single_marker = handler.addMarkers(<%= raw @hash_single.to_json %>
);
    handler.map.centerOn(single_marker[0]); //allways 0 because there's only one
    handler.fitMapToBounds();
    handler.getMap().setZoom(18);
  }
);
</script>
		]]>
	</xsl:text>

		<div id="admin_panel">	
			<xsl:text disable-output-escaping="yes">
			<![CDATA[
			<div id="form-edit">
				<%= render("form") %>
			</div>
			<% if current_user %>
				<%= link_to " Anuluj", edit_door_path(@door), id: "cancel_edit_door", class: "glyphicon glyphicon-remove-sign text-warning", remote: :true %>
			 <%= link_to " Edytuj", edit_door_path(@door), id: "edit_door", remote: :true, class: "glyphicon glyphicon-edit text-warning" %><br/>
			 <%= link_to " Usun", door_path(@door), method: :delete, data: { confirm: "Czy na pewno chcesz usunac?" }, class: "glyphicon glyphicon-remove text-danger" %><br/>
			<% end %>
			<br/><%= link_to " Powrot", doors_path, class: "glyphicon glyphicon-arrow-left" %><br/>
			]]>
		</xsl:text>
	</div>

	</xsl:template>
</xsl:stylesheet>