Class {
	#name : 'TplActivateAccountPage',
	#superclass : 'TplUseTokenPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'accessing' }
TplActivateAccountPage class >> defaultModel [

	^ CynActivateAccountToken new
]

{ #category : 'web resources' }
TplActivateAccountPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.account.activate"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<div id="container">
		<form id="form">
			<ion-list>
				<ion-item>
					<ion-input id="token" type="text" label-placement="stacked" readonly></ion-input>
				</ion-item>
			</ion-list>
		</form>
		<ion-note class="ion-margin-horizontal"><cyn-text text="app.note.account.activate.action"></cyn-text></ion-note>
		<ion-button id="submit-button" expand="block"><cyn-text text="app.button.label.account.activate"></cyn-text></ion-button>
	</div>
</ion-content>'
]

{ #category : 'operations' }
TplActivateAccountPage >> doOperation [

	^ self doOperation: [ self taskToken activate ]
]

{ #category : 'accessing' }
TplActivateAccountPage >> loadingOperationText [

	^ #'app.loading.account.activate' langText
]

{ #category : 'view' }
TplActivateAccountPage >> showExpiredTokenMessage [

	self app
		showAlertTitle: #'app.alert.title.account.activate.failed' langText
		message: #'app.alert.message.account.activate.expired' langText.

	"Go to register account page"
	self navigateUrl: '/register'
]

{ #category : 'view' }
TplActivateAccountPage >> showIncorrectTokenMessage [

	self app
		showAlertTitle: #'app.alert.title.account.activate.failed' langText
		message: #'app.alert.message.account.activate.token' langText.

	"Go to register account page"
	self navigateUrl: '/register'
]

{ #category : 'view' }
TplActivateAccountPage >> showSuccess [

	self app
		showAlertTitle: #'app.alert.title.account.activate.success' langText
		message: #'app.alert.message.account.activate.success' langText
]
