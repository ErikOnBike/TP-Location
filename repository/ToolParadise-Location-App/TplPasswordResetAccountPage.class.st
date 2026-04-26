Class {
	#name : 'TplPasswordResetAccountPage',
	#superclass : 'TplUseTokenPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'accessing' }
TplPasswordResetAccountPage class >> defaultModel [

	^ CynChangePasswordToken new
]

{ #category : 'web resources' }
TplPasswordResetAccountPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.account.passwordReset"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<div id="container">
		<form id="form">
			<ion-list>
				<ion-item>
					<ion-input id="token" type="text" label-placement="stacked" readonly></ion-input>
				</ion-item>
				<ion-item>
					<ion-input id="password" label-placement="stacked" type="password" autocomplete="new-password">
						<ion-input-password-toggle slot="end"></ion-input-password-toggle>				
					</ion-input>
				</ion-item>
			</ion-list>
		</form>
		<ion-note class="ion-margin-horizontal"><cyn-text text="app.note.account.passwordReset.action"></cyn-text></ion-note>
		<ion-button id="submit-button" expand="block"><cyn-text text="app.button.label.account.passwordReset"></cyn-text></ion-button>
	</div>
</ion-content>'
]

{ #category : 'binding' }
TplPasswordResetAccountPage >> boundProperties [

	^ super boundProperties,
		#(password)
]

{ #category : 'operations' }
TplPasswordResetAccountPage >> doOperation [

	^ self doOperation: [ self taskToken change ]
]

{ #category : 'accessing' }
TplPasswordResetAccountPage >> loadingOperationText [

	^ #'app.loading.account.passwordReset' langText
]

{ #category : 'view' }
TplPasswordResetAccountPage >> showExpiredTokenMessage [

	self app
		showAlertTitle: #'app.alert.title.account.passwordReset.failed' langText
		message: #'app.alert.message.account.passwordReset.expired' langText.

	"Go to request password change page"
	self navigateUrl: '/change-password'
]

{ #category : 'view' }
TplPasswordResetAccountPage >> showIncorrectTokenMessage [

	self app
		showAlertTitle: #'app.alert.title.account.passwordReset.failed' langText
		message: #'app.alert.message.account.passwordReset.token' langText.

	"Go to request password change page"
	self navigateUrl: '/change-password'
]

{ #category : 'view' }
TplPasswordResetAccountPage >> showSuccess [

	self app
		showAlertTitle: #'app.alert.title.account.passwordReset.success' langText
		message: #'app.alert.message.account.passwordReset.success' langText
]
