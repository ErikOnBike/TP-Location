Class {
	#name : 'TpLocation',
	#superclass : 'CynPropertyEntity',
	#instVars : [
		'#lat => CynPropertySlot',
		'#lon => CynPropertySlot',
		'#timestamp => CynPropertySlot'
	],
	#category : 'ToolParadise-Location-Data-Model',
	#package : 'ToolParadise-Location-Data',
	#tag : 'Model'
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
