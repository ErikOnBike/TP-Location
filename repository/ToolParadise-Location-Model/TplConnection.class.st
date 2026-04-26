Class {
	#name : 'TplConnection',
	#superclass : 'CynPropertyEntity',
	#instVars : [
		'#otherId => CynPropertySlot',
		'#name => CynPropertySlot'
	],
	#category : 'ToolParadise-Location-Model-Core',
	#package : 'ToolParadise-Location-Model',
	#tag : 'Core'
}

{ #category : 'accessing - generated' }
TplConnection class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id otherId name)
]

{ #category : 'accessing - generated' }
TplConnection class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id otherId name)
]

{ #category : 'accessing' }
TplConnection >> name [

	^ name
]

{ #category : 'accessing' }
TplConnection >> otherId [

	^ otherId
]
