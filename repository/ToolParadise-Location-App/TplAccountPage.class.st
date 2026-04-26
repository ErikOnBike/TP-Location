Class {
	#name : 'TplAccountPage',
	#superclass : 'TplPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'tags' }
TplAccountPage class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : 'testing' }
TplAccountPage class >> isMainPage [

	^ true
]

{ #category : 'testing' }
TplAccountPage class >> isModelPage [

	^ true
]

{ #category : 'testing' }
TplAccountPage class >> isPublic [

	^ true
]

{ #category : 'accessing' }
TplAccountPage >> account [

	^ model
]

{ #category : 'binding' }
TplAccountPage >> boundProperties [

	^ super boundProperties,
		#(email)
]

{ #category : 'operations' }
TplAccountPage >> doOperation [

	self subclassResponsibility
]

{ #category : 'event handling' }
TplAccountPage >> handleSubmitForm [

	self validateModelIfValid: [
		self doOperation
			ifTrue: [ self handleFormSubmitted ] ]
]

{ #category : 'testing' }
TplAccountPage >> workOnCopy [

	^ false
]
