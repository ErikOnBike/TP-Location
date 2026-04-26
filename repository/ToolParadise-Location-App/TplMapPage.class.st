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
TplMapPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.map"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	Hello world
</ion-content>'
]
