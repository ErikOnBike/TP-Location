Extension { #name : 'TplPreferences' }

{ #category : '*ToolParadise-Location-Data' }
TplPreferences class >> accountId: aString [

	^ self basicNew
		initializeWithAccountId: aString ;
		yourself
]

{ #category : '*ToolParadise-Location-Data' }
TplPreferences >> initializeWithAccountId: aString [

	self initialize.

	accountId := aString
]
