Class {
	#name : 'TpLocationRestApiService',
	#superclass : 'CynLocalAccountRestApiService',
	#category : 'ToolParadise-Location-Data-Service',
	#package : 'ToolParadise-Location-Data',
	#tag : 'Service'
}

{ #category : 'API - locations' }
TpLocationRestApiService >> addLocation: aLocation accountId: aString [

	"Assign id and timestamp to location"
	aLocation
		id: self newId ;
		addTimestamp.

	modelDatabase
		performOne: #createLocation
		statement: 'INSERT INTO locations (id, timestamp, lat, lon) VALUES (:id, :timestamp, :lat, :lon)'
		bind: {
			#id -> aLocation id.
			#timestamp -> aLocation timestamp.
			#lat -> aLocation lat.
			#lon -> aLocation lon } asDictionary
]

{ #category : 'API' }
TpLocationRestApiService >> location: aRestRequest response: aRestResponse [

	<post: '/api/location'>

	| body location |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	location := self extractNewObject: TpLocation fromBody: body.

	self addLocation: location accountId: aRestRequest accountId.

	self sendEmptyResponse: aRestResponse
]
