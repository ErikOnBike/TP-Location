Class {
	#name : 'TplRegisterAccountPage',
	#superclass : 'TplAccountPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'testing' }
TplRegisterAccountPage class >> allowsDirectLink [

	^ true
]

{ #category : 'accessing' }
TplRegisterAccountPage class >> defaultModel [

	^ CynRegisterAccount new
]

{ #category : 'testing' }
TplRegisterAccountPage class >> isDefaultForUrl: aString [

	^ aString = '/register'
]

{ #category : 'web resources' }
TplRegisterAccountPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.account.register"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<div id="container">
		<form id="form">
			<ion-list>
				<ion-item>
					<ion-input id="email" type="email" label-placement="stacked" autocomplete="email"></ion-input>
				</ion-item>
				<ion-item>
					<ion-input id="password" label-placement="stacked" type="password" autocomplete="new-password">
						<ion-input-password-toggle slot="end"></ion-input-password-toggle>				
					</ion-input>
				</ion-item>
			</ion-list>
		</form>
		<ion-note class="ion-margin-horizontal">
			<cyn-text text="app.note.account.register.action"></cyn-text>
		</ion-note>
	</div>
</ion-content>'
]

{ #category : 'binding' }
TplRegisterAccountPage >> boundProperties [

	^ super boundProperties,
		#(password)
]

{ #category : 'operations' }
TplRegisterAccountPage >> doOperation [

	^ self doOperation: [ self account register ]
]

{ #category : 'event handling' }
TplRegisterAccountPage >> handleError: anError [

	anError statusCode = CynRestResponseError codeConflict
		ifTrue: [
			self app
				showAlertTitle: #'app.alert.title.account.register.conflict' langText
				message: #'app.alert.message.account.register.conflict' langText.

			^ false ].
	^ super handleError: anError
]

{ #category : 'event handling' }
TplRegisterAccountPage >> handleFormSubmitted [

	self app
		showAlertTitle: #'app.alert.title.account.register.success' langText
		message: #'app.alert.message.account.register.success' langText.

	"Depending how we got here, reload home or close page"
	self isDirectLinked
		ifTrue: [ self navigateUrl: '/' ]
		ifFalse: [ self close ]
]

{ #category : 'accessing' }
TplRegisterAccountPage >> loadingOperationText [

	^ #'app.loading.account.register' langText
]

{ #category : 'view - customization' }
TplRegisterAccountPage >> toolbarEndButtonText [

	^ #'app.button.label.account.register'
]
