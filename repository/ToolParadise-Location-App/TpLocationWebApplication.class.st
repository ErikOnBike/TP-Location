Class {
	#name : 'TpLocationWebApplication',
	#superclass : 'CynMobileWebApplication',
	#category : 'ToolParadise-Location-App-Application',
	#package : 'ToolParadise-Location-App',
	#tag : 'Application'
}

{ #category : 'accessing' }
TpLocationWebApplication class >> allowedPackages [

	"Set the allowed packages for the installation checker.

	Include:
		Package containing the Location Model (through TpLocation)"

	^ super allowedPackages, { TplLocation package }
]

{ #category : 'accessing' }
TpLocationWebApplication class >> app [

	^ #'tp-location'
]
