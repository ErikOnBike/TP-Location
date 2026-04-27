Class {
	#name : 'TplMapPage',
	#superclass : 'TplPage',
	#instVars : [
		'map',
		'path',
		'marker',
		'updateTimer',
		'userMovedMap'
	],
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

{ #category : 'testing' }
TplMapPage class >> isMainPage [

	^ true
]

{ #category : 'web resources' }
TplMapPage class >> style [

	<webResource: #css>

	^ super style, '
#map {
	position: relative;
	width: 90%;
	height: 90%;
	margin-left: auto;
	margin-right: auto;
}
#lastUpdated {
	position: absolute;
	top: 8px;
	right: 8px;
	padding: 3px;
	color: #333;
	background-color: rgba(255, 255, 255, .2);
	z-index: 1000;
}
#center {
	position: absolute;
	bottom: 20px;
	right: 8px;
	font-size: 2em;
	z-index: 1000;
}
::slotted(div:empty)::after {
	display: block;
	content: "Waiting for location data...";
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
	<div id="map">
		<div id="lastUpdated"></div>
		<slot name="map"></slot>
		<ion-icon id="center" name="navigate-circle" slot="icon-only"></ion-icon>
	</div>
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

{ #category : 'view' }
TplMapPage >> beCentered [

	userMovedMap := false.

	self updatePath
]

{ #category : 'view' }
TplMapPage >> createMapAround: aLocation [

	| tileLayer |

	map ifNotNil: [
		userMovedMap
			ifFalse: [ map flyTo: aLocation asLatLon ].
		^ self ].

	"Create the map (centered and zoomed)"
	map := CpLeafletMap element: (self firstChildAtSlotNamed: #map) options: (CpLeafletMapOptions new
		center: aLocation asLatLon ;
		zoom: 16 ;
		yourself).

	"Ensure we don't auto-pan when user interacted with the map"
	map on: #dragstart handler: [ userMovedMap := true ].

	"Ensure we have tiles to show"
	tileLayer := CpLeafletTileLayer urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' options: (CpLeafletTileLayerOptions new
		attribution: '&copy; OpenStreetMap contributors' ;
		keepBuffer: 4;
		yourself).

	tileLayer addTo: map.

	"Show leafletjs as product"
	(map propertyAt: #attributionControl) apply: #setPrefix withArguments: { '<a href="https://leafletjs.com" target="_blank">leafletjs.com</a>' }
]

{ #category : 'initialization' }
TplMapPage >> initialize [

	super initialize.

	userMovedMap := false.

	self appendChild: (CpHtmlElement newWithTag: #div) atSlotNamed: #map
]

{ #category : 'initialization' }
TplMapPage >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedElementWithId: #center)
		when: CpClickEvent deferSend: #beCentered to: self
]

{ #category : 'view' }
TplMapPage >> locations [

	| locations lastUpdated |

	[
		locations := self model locations.
		locations ifNotEmpty: [
			lastUpdated := locations first timestamp.
			(self shadowedElementWithId: #lastUpdated) textContent: (CpJavaScriptDate fromSeconds: lastUpdated) dateAndTimeString ]
	] on: Error do: [ :error |
		locations := #().
		self app showToast: 'Failed to retrieve location' ].

	^ locations
]

{ #category : 'initialization' }
TplMapPage >> release [

	self stopUpdateTimer.

	marker ifNotNil: [
		map ifNotNil: [ marker removeFrom: map ].
		marker remove.
		marker := nil ].

	path ifNotNil: [
		map ifNotNil: [ path removeFrom: map ].
		path remove.
		path := nil ].

	map ifNotNil: [
		map remove.
		map := nil ].

	super release
]

{ #category : 'view' }
TplMapPage >> startUpdateTimer [

	self stopUpdateTimer.

	updateTimer := CpGlobalThis setTimeout: 6000 thenDo: [ self updatePath ]
]

{ #category : 'view' }
TplMapPage >> stopUpdateTimer [

	updateTimer ifNil: [ ^ self ].

	CpGlobalThis clearTimeout: updateTimer.

	updateTimer := nil
]

{ #category : 'view' }
TplMapPage >> updateBeforeNavigate [

	super updateBeforeNavigate.

	self updatePath
]

{ #category : 'view' }
TplMapPage >> updatePath [

	"Update the recent path"

	"Ensure we're not running multiple updates simultaneously"
	self stopUpdateTimer.

	"If not active, retry later"
	self isActive
		ifFalse: [ ^ self startUpdateTimer ].

	"Update the path"
	self locations
		ifNotEmpty: [ :locations |

			| coords |
			coords := locations collect: [ :each | each asLatLon ].

			"Create map if not created yet (otherwise it will center the map)"
			self createMapAround: locations first.

			"Update or create path"
			path
				ifNotNil: [ path setLatLngs: coords ]
				ifNil: [
					path := CpLeafletPolyline latLngs: coords.
					path addTo: map ].

			"Update or create marker"
			marker
				ifNotNil: [ marker setLatLng: coords first ]
				ifNil: [
					marker := CpLeafletMarker latLng: coords first.
					marker addTo: map ] ]
		ifEmpty: [

			"Remove path if locations have become empty"
			path ifNotNil: [
				path removeFrom: map.
				path := nil ].

			"Remove marker if locations have become empty"
			marker ifNotNil: [
				marker removeFrom: map.
				marker := nil ] ].

	self startUpdateTimer
]
