Class {
	#name : 'TplMapPage',
	#superclass : 'TplPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'accessing' }
TplMapPage class >> defaultModel [

	^ self app firstConnection
]

{ #category : 'web resources' }
TplMapPage class >> globalStyle [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
.leaflet-container {
	width: 100%;
	height: 100%;
}'
]

{ #category : 'web resources' }
TplMapPage class >> style [

	<webResource: #css>

	^ super style, '
#map {
	width: 90%;
	height: 90%;
	margin-left: auto;
	margin-right: auto;
	background-color: rgba(0, 0, 255, .1);
}'
]

{ #category : 'web resources' }
TplMapPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.map"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<div id="map"><slot name="map"></slot></div>
</ion-content>'
]

{ #category : 'view' }
TplMapPage >> activeChildView [

	"Ensure the map (which needs to be exposed to the light DOM
	is not recognized as an (active) child view"

	^ nil
]

{ #category : 'view' }
TplMapPage >> activeChildViewsDo: aBlock [

	"Ensure the map (which needs to be exposed to the light DOM
	is not recognized as an (active) child view"

	"Do nothing"
]

{ #category : 'initialization' }
TplMapPage >> initialize [

	super initialize.

	self appendChild: (CpHtmlElement newWithTag: #div) atSlotNamed: #map
]

{ #category : 'accessing' }
TplMapPage >> map [

	^ self shadowedElementWithId: #map
]

{ #category : 'view - customization' }
TplMapPage >> updateBeforeNavigate [

	| map tileLayer |

	super updateBeforeNavigate.

	map := CpLeafletMap element: (self firstChildAtSlotNamed: #map) options: (CpLeafletMapOptions new
		center: { 52.2 . 5.2 } ;
		zoom: 13 ;
		yourself).

	tileLayer := CpLeafletTileLayer urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' options: (CpLeafletTileLayerOptions new
		attribution: '&copy; OpenStreetMap contributors' ;
		yourself).

	tileLayer addTo: map.

	"No politics please: remove Ukranian flag"
	(map propertyAt: #attributionControl) apply: #setPrefix withArguments: { '' }.

	self model locations do: [ :each |
		| marker |
		marker := CpLeafletMarker lat: each lat lon: each lon.
		marker addTo: map ]
]
