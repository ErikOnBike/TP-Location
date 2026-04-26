Class {
	#name : 'TplLocation',
	#superclass : 'CynPropertyEntity',
	#instVars : [
		'#lat => CynPropertySlot',
		'#lon => CynPropertySlot',
		'#action => CynPropertySlot',
		'#timestamp => CynPropertySlot'
	],
	#category : 'ToolParadise-Location-Model-Core',
	#package : 'ToolParadise-Location-Model',
	#tag : 'Core'
}

{ #category : 'accessing - generated' }
TplLocation class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id lat lon action timestamp)
]

{ #category : 'accessing - generated' }
TplLocation class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id lat lon action timestamp)
]

{ #category : 'accessing' }
TplLocation >> action [

	^ action
]

{ #category : 'accessing' }
TplLocation >> addTimestamp [

	timestamp := CpJavaScriptDate timestampNow
]

{ #category : 'accessing' }
TplLocation >> lat [

	^ lat
]

{ #category : 'accessing' }
TplLocation >> lon [

	^ lon
]

{ #category : 'accessing' }
TplLocation >> timestamp [

	^ timestamp
]
