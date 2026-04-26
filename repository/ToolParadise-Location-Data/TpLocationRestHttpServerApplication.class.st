Class {
	#name : 'TpLocationRestHttpServerApplication',
	#superclass : 'CynRestHttpServerApplication',
	#category : 'ToolParadise-Location-Data-Application',
	#package : 'ToolParadise-Location-Data',
	#tag : 'Application'
}

{ #category : 'accessing' }
TpLocationRestHttpServerApplication class >> allowedPackages [

	"Answer a collection of Packages which are allowed to contain classes to install in the receiver"

	^ super allowedPackages, { TplLocation package }
]

{ #category : 'actions' }
TpLocationRestHttpServerApplication >> load [

	super load.

	self installClass: TpLocationRestApiService
]
