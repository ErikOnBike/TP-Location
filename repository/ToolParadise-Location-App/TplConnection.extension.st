Extension { #name : 'TplConnection' }

{ #category : '*ToolParadise-Location-App' }
TplConnection >> locations [

	"Answer the current collection of recent locations"

	^ TplLocation
		restReadUsingUri: self locationsUri
		timeoutPeriod: self restReadTimeoutPeriod
]

{ #category : '*ToolParadise-Location-App' }
TplConnection >> locationsUri [

	^ '{1}/{2}/locations' format: { self class uri . self id }
]

{ #category : '*ToolParadise-Location-App' }
TplConnection class >> uri [

	^ '/connections'
]
