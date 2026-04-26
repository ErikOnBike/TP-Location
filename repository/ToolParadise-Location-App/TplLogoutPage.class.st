Class {
	#name : 'TplLogoutPage',
	#superclass : 'TplPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'web resources' }
TplLogoutPage class >> style [

	<webResource: #css>

	^ super style, '
#button-wrapper {
	display: flex;
	justify-content: center;
}'
]

{ #category : 'web resources' }
TplLogoutPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.logout"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<div id="container">
		<div id="button-wrapper">
			<ion-button id="back-button" size="small" color="secondary"><cyn-text text="app.button.label.logout.back"></cyn-text></ion-button>
			<ion-button id="logout-button" color="danger" size="small"><cyn-text text="app.button.label.logout.do"></cyn-text></ion-button>
		</div>
	</div>
</ion-content>'
]

{ #category : 'initialization' }
TplLogoutPage >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedElementWithId: #'back-button')
		when: CpClickEvent deferSend: #close to: self.

	(self shadowedElementWithId: #'logout-button')
		when: CpClickEvent deferSend: #logout to: self
]

{ #category : 'actions' }
TplLogoutPage >> logout [

	self app logout
]
