Class {
	#name : 'TpLocation',
	#superclass : 'CynPropertyEntity',
	#instVars : [
		'#lat => CynPropertySlot',
		'#lon => CynPropertySlot',
		'#timestamp => CynPropertySlot'
	],
	#category : 'ToolParadise-Location-Model-Core',
	#package : 'ToolParadise-Location-Model',
	#tag : 'Core'
}

{ #category : 'accessing - generated' }
TpLocation class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id lat lon timestamp)
]

{ #category : 'accessing - generated' }
TpLocation class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id lat lon timestamp)
]

{ #category : 'accessing' }
TpLocation >> addTimestamp [

	timestamp := CpJavaScriptDate timestampNow
]

{ #category : 'accessing' }
TpLocation >> lat [

	^ lat
]

{ #category : 'accessing' }
TpLocation >> lon [

	^ lon
]

{ #category : 'accessing' }
TpLocation >> timestamp [

	^ timestamp
]
