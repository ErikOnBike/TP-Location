Class {
	#name : 'TplConnectionsPage',
	#superclass : 'TplPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'web resources' }
TplConnectionsPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.connections"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<ion-refresher id="refresher" slot="fixed">
		<ion-refresher-content></ion-refresher-content>
	</ion-refresher>
	<ion-list id="connection-list">
		<template>
			<ion-item>
				<!-- TODO -->
			</ion-item>
		</template>
	</ion-list>
</ion-content>'
]
