Class {
	#name : 'TplUseTokenPage',
	#superclass : 'TplPage',
	#instVars : [
		'token'
	],
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'testing' }
TplUseTokenPage class >> allowsDirectLink [

	^ true
]

{ #category : 'testing' }
TplUseTokenPage class >> isMainPage [

	^ true
]

{ #category : 'testing' }
TplUseTokenPage class >> isModelPage [

	^ true
]

{ #category : 'testing' }
TplUseTokenPage class >> isPublic [

	^ true
]

{ #category : 'web resources' }
TplUseTokenPage class >> style [

	<webResource: #css>

	^ super style, '
ion-note {
	margin-top: 12px;
	margin-bottom: 20px;
}'
]

{ #category : 'binding' }
TplUseTokenPage >> boundProperties [

	^ super boundProperties,
		#(token)
]

{ #category : 'operations' }
TplUseTokenPage >> doOperation [

	self subclassResponsibility
]

{ #category : 'event handling' }
TplUseTokenPage >> handleError: anError [

	anError statusCode = CynRestResponseError codeNotFound
		ifTrue: [
			self showIncorrectTokenMessage.
			^ false ].

	anError statusCode = CynRestResponseError codeUnprocessableEntity
		ifTrue: [
			self showExpiredTokenMessage.
			^ false ].

	^ super handleError: anError
]

{ #category : 'event handling' }
TplUseTokenPage >> handleFormSubmitted [

	self showSuccess.

	"Restart the app"
	self navigateUrl: '/'
]

{ #category : 'event handling' }
TplUseTokenPage >> handleSubmitForm [

	self validateModelIfValid: [
		self doOperation
			ifTrue: [ self handleFormSubmitted ] ]
]

{ #category : 'initialization' }
TplUseTokenPage >> initializeShadowRoot [

	super initializeShadowRoot.

	self submitButton
		when: CpClickEvent deferSend: #handleSubmitForm to: self 
]

{ #category : 'accessing' }
TplUseTokenPage >> model: aModel [

	super model: aModel.

	"Extract token from the current URL and validate"
	token := self fromUrlExtractParam: #code ifValid: [ :value | CynTokenPropertyConstraint default isValidValue: value ].
	token ifNil: [ self showInvalidToken ].

	model token: token
]

{ #category : 'view' }
TplUseTokenPage >> showExpiredTokenMessage [

	self subclassResponsibility
]

{ #category : 'view' }
TplUseTokenPage >> showIncorrectTokenMessage [

	self subclassResponsibility
]

{ #category : 'view' }
TplUseTokenPage >> showInvalidToken [

	self app
		showAlertTitle: #'app.alert.title.token.invalid' langText
		message: #'app.alert.message.token.invalid' langText.

	"Restart the app"
	self navigateUrl: '/'
]

{ #category : 'view' }
TplUseTokenPage >> showSuccess [

	self subclassResponsibility
]

{ #category : 'accessing' }
TplUseTokenPage >> submitButton [

	^ self shadowedElementWithId: #'submit-button'
]

{ #category : 'accessing' }
TplUseTokenPage >> taskToken [

	^ model
]

{ #category : 'view' }
TplUseTokenPage >> toolbarEndButtons [

	^ #()
]
