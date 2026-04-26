Class {
	#name : 'TplPasswordForgottenAccountPage',
	#superclass : 'TplAccountPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'testing' }
TplPasswordForgottenAccountPage class >> allowsDirectLink [

	^ true
]

{ #category : 'accessing' }
TplPasswordForgottenAccountPage class >> defaultModel [

	^ CynPasswordForgottenAccount new
]

{ #category : 'testing' }
TplPasswordForgottenAccountPage class >> isDefaultForUrl: aString [

	^ aString = '/change-password'
]

{ #category : 'web resources' }
TplPasswordForgottenAccountPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.account.passwordForgotten"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<div id="container">
		<form id="form">
			<ion-list>
				<ion-item>
					<ion-input id="email" type="email" label-placement="stacked" autocomplete="email"></ion-input>
				</ion-item>
			</ion-list>
		</form>
		<ion-note class="ion-margin-horizontal">
			<cyn-text text="app.note.account.passwordForgotten.action"></cyn-text>
		</ion-note>
	</div>
</ion-content>'
]

{ #category : 'operations' }
TplPasswordForgottenAccountPage >> doOperation [

	^ self doOperation: [ self account sendPasswordResetMail ]
]

{ #category : 'operations' }
TplPasswordForgottenAccountPage >> handleFormSubmitted [

	self app
		showAlertTitle: #'app.alert.title.account.passwordReset' langText
		message: #'app.alert.message.account.passwordReset' langText.

	"Depending how we got here, reload home or close page"
	self isDirectLinked
		ifTrue: [ self navigateUrl: '/' ]
		ifFalse: [ self close ]
]

{ #category : 'operations' }
TplPasswordForgottenAccountPage >> loadingOperationText [

	^ #'app.loading.account.passwordForgotten' langText
]

{ #category : 'view - customization' }
TplPasswordForgottenAccountPage >> toolbarEndButtonText [

	^ #'app.button.label.account.passwordForgotten'
]
