Class {
	#name : 'BaselineOfTpLocationApp',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfTpLocationApp',
	#package : 'BaselineOfTpLocationApp'
}

{ #category : 'baselines' }
BaselineOfTpLocationApp >> baseline: spec [

	<baseline>

	spec for: #common do: [

		"Dependencies"
		spec
			baseline: 'CodeParadise' with: [ spec loads: #('default') ; repository: 'github://ErikOnBike/CodeParadise:master' ].

		"Packages"
		spec
			package: 'ToolParadise-Location-App' with: [ spec requires: #('ToolParadise-Location-Data') ] ;
			package: 'ToolParadise-Location-Data' with: [ spec requires: #('ToolParadise-Location-Model') ] ;
			package: 'ToolParadise-Location-Model' with: [ spec requires: #('CodeParadise') ].

		"Groups"
		spec 
			group: 'default' with: #( 'Core' );

			group: 'Core' with: #( 'ToolParadise-Location-App' ) ]
]
