Class {
	#name : 'TplLoginAccountPage',
	#superclass : 'TplAccountPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'web resources' }
TplLoginAccountPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.account.login"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<div id="container">
		<form id="form">
			<ion-list>
				<ion-item>
					<ion-input id="email" label-placement="stacked" type="email" autocomplete="email"></ion-input>
				</ion-item>
				<ion-item>
					<ion-input id="password" label-placement="stacked" type="password" autocomplete="current-password">
						<ion-input-password-toggle slot="end"></ion-input-password-toggle>				
					</ion-input>
				</ion-item>
			</ion-list>
		</form>
		<ion-list lines="none">
			<ion-item>
				<a id="register-account-link"><cyn-text text="app.link.account.register"></cyn-text></a>
			</ion-item>
			<ion-item>
				<a id="password-forgotten-link"><cyn-text text="app.link.account.passwordForgotten"></cyn-text></a>
			</ion-item>
		</ion-list>
	</div>
</ion-content>'
]

{ #category : 'binding' }
TplLoginAccountPage >> boundProperties [

	^ super boundProperties,
		#(password)
]

{ #category : 'testing' }
TplLoginAccountPage >> canModalDismiss [

	^ false
]

{ #category : 'view' }
TplLoginAccountPage >> close [

	"Close the Page"

	"Reset the password, so it is not kept (too long) in memory"
	self account resetPassword.

	super close
]

{ #category : 'operations' }
TplLoginAccountPage >> doOperation [

	^ self doOperation: [
		self account login.

		"Reset the password, so it is not kept (too long) in memory"
		self account resetPassword.

		self keepResult ]
]

{ #category : 'event handling' }
TplLoginAccountPage >> handleClickPasswordForgotten [

	self showPasswordForgotten
]

{ #category : 'event handling' }
TplLoginAccountPage >> handleClickRegisterAccount [

	self showRegisterAccount
]

{ #category : 'event handling' }
TplLoginAccountPage >> handleError: anError [

	anError statusCode = CynRestResponseError codeUnauthorized
		ifTrue: [
			self app
				showAlertTitle: #'app.alert.title.account.login.failed' langText
				message: #'app.alert.message.account.login.failed' langText.

			^ false ].

	anError statusCode = CynRestResponseError codeConflict
		ifTrue: [
			self app
				showAlertTitle: #'app.alert.title.account.login.failed' langText
				message: #'app.alert.message.account.login.inactive' langText.

			^ false ].

	^ super handleError: anError
]

{ #category : 'initialization' }
TplLoginAccountPage >> initializeShadowRoot [

	super initializeShadowRoot.

	self registerAccountLink
		when: CpClickEvent deferSend: #handleClickRegisterAccount to: self.
	self passwordForgottenLink
		when: CpClickEvent deferSend: #handleClickPasswordForgotten to: self
]

{ #category : 'accessing' }
TplLoginAccountPage >> loadingOperationText [

	"Answer the text to be shown during (longer) operation"

	^ #'app.loading.account.login' langText
]

{ #category : 'accessing' }
TplLoginAccountPage >> passwordForgottenLink [

	^ self shadowedElementWithId: #'password-forgotten-link'
]

{ #category : 'accessing' }
TplLoginAccountPage >> registerAccountLink [

	^ self shadowedElementWithId: #'register-account-link'
]

{ #category : 'view' }
TplLoginAccountPage >> showPasswordForgotten [

	self
		navigateTo: AmPasswordForgottenAccountPage
		withModel: (CynPasswordForgottenAccount new
			email: self account email ;
			yourself)
]

{ #category : 'view' }
TplLoginAccountPage >> showRegisterAccount [

	self
		navigateTo: AmRegisterAccountPage
		withModel: (CynRegisterAccount new
			email: self account email ;
			yourself)
]

{ #category : 'view - customization' }
TplLoginAccountPage >> toolbarEndButtonText [

	^ #'app.button.label.account.login'
]

{ #category : 'view - customization' }
TplLoginAccountPage >> updateAfterNavigate [

	"If through activation a session has become available, close the receiver"

	super updateAfterNavigate.

	CynPropertyEntity restApiClient hasAccessToken
		ifTrue: [
			self account propertyAt: #success put: true.
			self closePage ]
]
