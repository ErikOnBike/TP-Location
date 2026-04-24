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
