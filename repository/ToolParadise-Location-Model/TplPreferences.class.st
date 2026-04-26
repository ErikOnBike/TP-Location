Class {
	#name : 'TplPreferences',
	#superclass : 'CynPropertyEntity',
	#instVars : [
		'#accountId => CynPropertySlot',
		'#language => CynPropertySlot'
	],
	#category : 'ToolParadise-Location-Model-Core',
	#package : 'ToolParadise-Location-Model',
	#tag : 'Core'
}

{ #category : 'accessing - generated' }
TplPreferences class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id accountId language)
]

{ #category : 'accessing' }
TplPreferences class >> languages [

	^ #(en nl)
]

{ #category : 'accessing - generated' }
TplPreferences class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id accountId language)
]

{ #category : 'accessing' }
TplPreferences >> accountId [

	^ accountId
]

{ #category : 'accessing' }
TplPreferences >> language [

	^ language
]
