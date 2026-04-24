Class {
	#name : 'TpLocationRestHttpServerApplication',
	#superclass : 'CynRestHttpServerApplication',
	#category : 'ToolParadise-Location-Data-Application',
	#package : 'ToolParadise-Location-Data',
	#tag : 'Application'
}

{ #category : 'actions' }
TpLocationRestHttpServerApplication >> load [

	super load.

	self installClass: TpLocationRestApiService
]
