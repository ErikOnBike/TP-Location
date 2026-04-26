Class {
	#name : 'TpLocationRestApiService',
	#superclass : 'CynLocalAccountRestApiService',
	#category : 'ToolParadise-Location-Data-Service',
	#package : 'ToolParadise-Location-Data',
	#tag : 'Service'
}

{ #category : 'API - accounts' }
TpLocationRestApiService >> activatedMailMessage [

	^ self newMailMessage
		subject: 'Je TP Location account is geactiveerd / Your TP Location account is activated' ;
		text: (('Hallo,

(English version below)

Je account voor TP Location is geactiveerd en klaar!

De link naar TP Location: {1}

Zonnige groet,
Erik

=== English version ===

Hello,

Your account for TP Location is activated and ready!

Link to TP Location: {1}

Sunny regards,
Erik' format: { config at: #url }) replaceAll: Character cr with: Character lf) ;
		html: (('<p>Hallo,</p>
<p>(English version below)</p>
<p>Je account voor TP Location is geactiveerd en klaar!</p>
<p>Link naar TP Location: <a href="{1}">{1}</a></p>
<p>Zonnige groet,<br>
Erik</p>
<p></p>
<p>=== English version ===</p>
<p></p>
<p>Hello,</p>
<p>Your account for TP Location is activated and ready!</p>
<p>Link to TP Location: <a href="{1}">{1}</a></p>
<p>Sunny regards,<br>
Erik</p>' format: { config at: #url }) replaceAll: Character cr with: Character lf) ;
		yourself
]

{ #category : 'API - accounts' }
TpLocationRestApiService >> activationTokenMailMessageWith: tokenString [

	^ self newMailMessage
		subject: 'Activeer je TP Location account / Activate your TP Location account' ;
		text: (('Hallo,

(English version below)

Welkom als nieuwe gebruiker in TP Location. We zijn blij je aan boord te hebben.

Je account is bijna klaar, je hoeft deze alleen nog maar te activeren. Klik op de onderstaande activatielink om dit te doen. Na activatie ontvang je nogmaals een mail ter bevestiging. De activatielink is 30 minuten geldig. Na 30 minuten zul je opnieuw je account moeten aanmaken om een nieuwe activatielink te ontvangen.
Activatielink: {1}/activate-account?code={2}

Mocht je zelf geen account hebben aangemaakt voor TP Location, kun je deze mail vergeten. Zonder activatie zal het account na enige tijd automatisch verwijderd worden. Anderen kunnen het account niet activeren zonder bovenstaande link.

Zonnige groet,
Erik

=== English version ===	

Hello,

Welcome as a new user in TP Location. We are happy to have you on board.

Your account is almost ready, you only need to activate it. Please click on the activation link below to do this. After activation you will receive another mail confirming this. The activation link is valid for 30 minutes. After 30 minutes you will have to create the account again to receive a new activation link.
Activation link: {1}/activate-account?code={2}

In case you did not request an account for TP Location, please ignore this mail. Without activation the account will be removed automatically after some time. Others can not activate the account without the above link.

Sunny regards,
Erik' format: { config at: #url . tokenString }) replaceAll: Character cr with: Character lf) ;
		html: (('
<p>Hallo,</p>
<p>(English version below)</p>
<p>Welkom als nieuwe gebruiker in TP Location. We zijn blij je aan boord te hebben.</p>
<p>Je account is bijna klaar, je hoeft deze alleen nog maar te activeren. Klik op de onderstaande activatielink om dit te doen. Na activatie ontvang je nogmaals een mail ter bevestiging. De activatielink is 30 minuten geldig. Na 30 minuten zul je opnieuw je account moeten aanmaken om een nieuwe activatielink te ontvangen.</p>
<p>Activatielink: <a href="{1}/activate-account?code={2}">{1}/activate-account?code={2}</a></p>
<p>Mocht je zelf geen account hebben aangemaakt voor TP Location, kun je deze mail vergeten. Zonder activatie zal het account na enige tijd automatisch verwijderd worden. Anderen kunnen het account niet activeren zonder bovenstaande link.</p>
<p>Zonnige groet,<br>
Erik</p>
<p></p>
<p>=== English version ===</p>
<p></p>
<p>Hello,</p>
<p>Welcome as a new user in TP Location. We are happy to have you on board.</p>
<p>Your account is almost ready, you only need to activate it. Please click on the activation link below to do this. After activation you will receive another mail confirming this. The activation link is valid for 30 minutes. After 30 minutes you will have to create the account again to receive a new activation link.</p>
<p>Activation link: <a href="{1}/activate-account?code={2}">{1}/activate-account?code={2}</a></p>
<p>In case you did not request an account for TP Location, please ignore this mail. Without activation the account will be removed automatically after some time. Others can not activate the account without the above link.</p>
<p>Sunny regards,<br>
Erik</p>' format: { config at: #url . tokenString }) replaceAll: Character cr with: Character lf) ;
		yourself
]

{ #category : 'API - locations' }
TpLocationRestApiService >> addLocation: aLocation accountId: aString [

	"Assign id and timestamp to location"
	aLocation
		id: self newId ;
		addTimestamp.

	modelDatabase
		performOne: #createLocation
		statement: 'INSERT INTO locations (id, accountId, timestamp, lat, lon) VALUES (:id, :accountId, :timestamp, :lat, :lon)'
		bind: {
			#id -> aLocation id.
			#accountId -> aString.
			#timestamp -> aLocation timestamp.
			#lat -> aLocation lat.
			#lon -> aLocation lon } asDictionary
]

{ #category : 'API' }
TpLocationRestApiService >> addLocation: aRestRequest response: aRestResponse [

	<post: '/api/locations'>

	| body location |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	location := self extractNewObject: TplLocation fromBody: body.

	self addLocation: location accountId: aRestRequest accountId.

	self sendEmptyResponse: aRestResponse
]

{ #category : 'API - preferences' }
TpLocationRestApiService >> allPreferencesByAccountId: aString [

	"Use it like it is a collection, but actually only answer the single preference for the current account"

	| preferences |

	preferences := modelDatabase
		selectOne: #getPreferences
		statement: 'SELECT id, language FROM preferences WHERE accountId=:accountId AND deletedAt IS NULL'
		bind: { #accountId -> aString } asDictionary.

	^ Array with: (preferences ifNil: [ self createPreferencesForAccountId: aString ])
]

{ #category : 'API - accounts' }
TpLocationRestApiService >> alreadyCreatedMailMessage [

	^ self newMailMessage
		subject: 'Account for TP Location' ;
		text: (('Hallo,

(English version below)

Iemand heeft geprobeerd een nieuw account te maken in TP Location voor dit email-adres. Als je dit zelf gedaan hebt, weet dat je al een werkend account hebt. Er hoeft niets verder gedaan te worden.

Link naar TP Location: {1}

Als je niet zelf dit verzoek hebt gedaan voor een nieuw account, dan kun je deze mail negeren. Je account blijft ongewijzigd werken.

Zonnige groet,
Erik

=== English version ===

Hello,

Someone tried to create a new account in TP Location for this email address. If you did this yourself, please know you already have a working account and nothing needs to be done.

Link to TP Location: {1}

If you did not request a new account, just ignore this email. Your account remains working as it is, nothing is changed.

Sunny regards,
Erik' format: { config at: #url }) replaceAll: Character cr with: Character lf) ;
		html: (('<p>Hallo,</p>
<p>(English version below)</p>
<p>Iemand heeft geprobeerd een nieuw account te maken in TP Location voor dit email-adres. Als je dit zelf gedaan hebt, weet dat je al een werkend account hebt. Er hoeft niets verder gedaan te worden.</p>
<p>Link naar TP Location: <a href="{1}">{1}</a>.</p>
<p>Als je niet zelf dit verzoek hebt gedaan voor een nieuw account, dan kun je deze mail negeren. Je account blijft ongewijzigd werken.</p>
<p>Zonnige groet,<br>
Erik</p>
<p></p>
<p>=== English version ===</p>
<p></p>
<p>Hello,</p>
<p>Someone tried to create a new account in TP Location for this email address. If you did this yourself, please know you already have a working account and nothing needs to be done.</p>
<p>Link to TP Location: <a href="{1}">{1}</a>.</p>
<p>If you did not request a new account, just ignore this email. Your account remains working as it is, nothing is changed.</p>
<p>Sunny regards,<br>
Erik</p>' format: { config at: #url }) replaceAll: Character cr with: Character lf) ;
		yourself
]

{ #category : 'API' }
TpLocationRestApiService >> createAccount: aRestRequest response: aRestResponse [

	"Add a new Account to the Accounts collection.

	This method adds some check for a valid email address and if okay
	delegates the handling to the original handler."

	<post: '/api/accounts'>
	<public>

	| body account |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CynRegisterAccount fromBody: body.

	"Validate the email is allowed"
	(self isValidEmail: account email)
		ifFalse: [ CpNodeJSRestConflictError signal ].

	super createAccount: aRestRequest response: aRestResponse
]

{ #category : 'API - preferences' }
TpLocationRestApiService >> createPreferencesForAccountId: aString [

	| preferences |

	preferences := TplPreferences accountId: aString.

	"Assign id to preferences"
	preferences id: self newId.

	modelDatabase
		performOne: #createPreferences
		statement: 'INSERT INTO preferences (id, createdAt, accountId) VALUES (:id, :now, :accountId)'
		bind: {
			#id -> preferences id.
			#now -> CpJavaScriptDate timestampNow.
			#accountId -> preferences accountId } asDictionary.

	^ preferences
]

{ #category : 'API - locations' }
TpLocationRestApiService >> getConnectionLocations: connectionIdString forAccount: accountIdString [

	"Answer the 4 most recent locations of the specified connection"

	| locationAccountId |

	locationAccountId := modelDatabase
		selectValue: #getLocationAccountId
		statement: 'SELECT otherId FROM connections WHERE id=:id AND accountId=:accountId'
		bind: {
			#id -> connectionIdString.
			#accountId -> accountIdString } asDictionary.

	locationAccountId ifNil: [ CpNodeJSRestBadRequestError signal ].

	^ modelDatabase
		selectMany: #accountLocations
		statement: 'SELECT lat, lon, timestamp FROM locations WHERE accountId=:accountId ORDER BY timestamp DESC LIMIT 400'
		bind: { #accountId -> locationAccountId } asDictionary
]

{ #category : 'API' }
TpLocationRestApiService >> getConnectionLocations: aRestRequest response: aRestResponse [

	<get: '/api/connections/:id/locations'>
	<authorization: #validateConnection:>

	self send: (self getConnectionLocations: (aRestRequest pathParameterAt: #id) forAccount: aRestRequest accountId) response: aRestResponse
]

{ #category : 'API' }
TpLocationRestApiService >> getConnections: aRestRequest response: aRestResponse [

	<get: '/api/connections'>

	self send: (self getConnectionsOfAccount: aRestRequest accountId) response: aRestResponse
]

{ #category : 'API - connections' }
TpLocationRestApiService >> getConnectionsOfAccount: aString [

	"Answer the 4 most recent locations"

	^ modelDatabase
		selectMany: #getConnections
		statement: 'SELECT id, otherId, name FROM connections WHERE accountId=:accountId ORDER BY name'
		bind: (Dictionary with: #accountId -> aString)
]

{ #category : 'API' }
TpLocationRestApiService >> getPreferences: aRestRequest response: aRestResponse [

	"This acts like it retrieves a collection of preferences, but will only answer an Array with a single entry"

	<get: '/api/preferences'>

	self send: (self allPreferencesByAccountId: aRestRequest accountId) response: aRestResponse
]

{ #category : 'API - accounts' }
TpLocationRestApiService >> isValidEmail: aString [

	"Answer a Boolean indicating if the email is valid.
	All regular validation wrt email format have been performed.
	Only check if email matches the configuration settings."

	"The field allowedAccounts should contain either exact matching email
	addresses or a domain like '@toolparadise.nl'. All values in the
	allowedAccounts field MUST be lowercase."

	| email |

	aString isEmptyOrNil
		ifTrue: [ ^ false ].

	email := aString asLowercase.

	"Single sanity check on email"
	(email occurrencesOf: $@) = 1
		ifFalse: [ ^ false ].

	(config at: #allowedAccounts ifAbsent: [ ^ false ]) do: [ :each |
		((each beginsWith: '@') and: [ email endsWith: each ])
			ifTrue: [ ^ true ].
		each = email
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : 'API - accounts' }
TpLocationRestApiService >> passwordChangedMailMessage [

	^ self newMailMessage
		subject: 'Password changed for TP Location' ;
		text: (('Hallo,

(English version below)

Je hebt je wachtwoord voor TP Location succesvol gewijzigd.

Link naar TP Location: {1}

Zonnige groet,
Erik

=== English version ===

Hello,

You have changed the password for your TP Location account successfully.

Link to TP Location: {1}

Sunny regards,
Erik' format: { config at: #url }) replaceAll: Character cr with: Character lf) ;
		html: (('<p>Hallo,</p>
<p>(English version below)</p>
<p>Je hebt je wachtwoord voor TP Location succesvol gewijzigd.</p>
<p>Link naar TP Location: <a href="{1}">{1}</a>.</p>
<p>Zonnige groet,<br>
Erik</p>
<p></p>
<p>=== English version ===</p>
<p></p>
<p>Hello,</p>
<p>You have changed the password for your TP Location account successfully.</p>
<p>Link to TP Location: <a href="{1}">{1}</a>.</p>
<p>Sunny regards,<br>
Erik</p>' format: { config at: #url }) replaceAll: Character cr with: Character lf) ;
		yourself
]

{ #category : 'API - accounts' }
TpLocationRestApiService >> passwordResetTokenMailMessageWith: tokenString [

	^ self newMailMessage
		subject: 'Wachtwoord wijzigen voor TP Location / Password change for TP Location' ;
		text: (('Hallo,

(English version below)

Iemand heeft aangegeven dat jouw wachtwoord voor TP Location opnieuw ingesteld moet worden. Mocht je dit gedaan hebben, klik dan op de onderstaande link om dit te doen. Nadat je je wachtwoord hebt aangepast ontvang je nogmaals een mail ter bevestiging. De link is 30 minuten geldig. Na 30 minuten zul je opnieuw een verzoek voor het wijzigen van je wachtwoord moeten indienen (vanaf de login pagina) om een nieuwe link te ontvangen.
Link wijzigen wachtwoord: {1}/password-reset-account?code={2}

Mocht je zelf geen verzoek hebben gedaan om je wachtwoord te wijzigen, dan kun je deze mail negeren. Je account blijft ongewijzigd werken en je wachtwoord is ook niet gewijzigd.

Zonnige groet,
Erik

=== English version ===	

Hello,

Someone has requested to change the password of your TP Location account. If you did this, please click on the link below to do this. After you updated your password you will receive another mail confirming this. The link is valid for 30 minutes. After 30 minutes you will have to request a password change again (from the login page) to receive a new link.
Change password link: {1}/password-reset-account?code={2}

In case you did not request a password change for TP Location, please ignore this mail. Your account remains working without change and your password is also unchanged.

Sunny regards,
Erik' format: { config at: #url . tokenString }) replaceAll: Character cr with: Character lf) ;
		html: (('
<p>Hallo,</p>
<p>(English version below)</p>
<p>Iemand heeft aangegeven dat jouw wachtwoord voor TP Location opnieuw ingesteld moet worden. Mocht je dit gedaan hebben, klik dan op de onderstaande link om dit te doen. Nadat je je wachtwoord hebt aangepast ontvang je nogmaals een mail ter bevestiging. De link is 30 minuten geldig. Na 30 minuten zul je opnieuw een verzoek voor het wijzigen van je wachtwoord moeten indienen (vanaf de login pagina) om een nieuwe link te ontvangen.</p>
<p>Link wijzigen wachtwoord: <a href="{1}/password-reset-account?code={2}">{1}/password-reset-account?code={2}</a></p>
<p>Mocht je zelf geen verzoek hebben gedaan om je wachtwoord te wijzigen, dan kun je deze mail negeren. Je account blijft ongewijzigd werken en je wachtwoord is ook niet gewijzigd.</p>
<p>Zonnige groet,<br>
Erik</p>
<p></p>
<p>=== English version ===</p>
<p></p>
<p>Hello,</p>
<p>Someone has requested to change the password of your TP Location account. If you did this, please click on the link below to do this. After you updated your password you will receive another mail confirming this. The link is valid for 30 minutes. After 30 minutes you will have to request a password change again (from the login page) to receive a new link.</p>
<p>Change password link: <a href="{1}/password-reset-account?code={2}">{1}/password-reset-account?code={2}</a></p>
<p>In case you did not request a password change for TP Location, please ignore this mail. Your account remains working without change and your password is also unchanged.</p>
<p>Suny regards,<br>
Erik</p>' format: { config at: #url . tokenString }) replaceAll: Character cr with: Character lf) ;
		yourself
]

{ #category : 'API - preferences' }
TpLocationRestApiService >> updatePreferences: aPreferences accountId: aString [

	modelDatabase
		performOne: #updatePreferences
		statement: 'UPDATE preferences SET updatedAt=:now, language=:language WHERE id=:id AND deletedAt IS NULL'
		bind: {
			#id -> aPreferences id.
			#now -> CpJavaScriptDate timestampNow.
			#language -> aPreferences language } asDictionary
]

{ #category : 'API' }
TpLocationRestApiService >> updatePreferences: aRestRequest response: aRestResponse [

	<put: '/api/preferences/:id'>

	| body preferences |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	preferences := self extractObject: TplPreferences fromBody: body.

	(aRestRequest pathParameterAt: #id) = preferences id
		ifFalse: [ self errorInvalidInput ].

	self updatePreferences: preferences accountId: aRestRequest accountId.

	self sendEmptyResponse: aRestResponse
]

{ #category : 'API - authorization' }
TpLocationRestApiService >> validateConnection: aRestRequest [

	| accountId connectionId connectionExists |

	self validateAuthorizedRequest: aRestRequest.

	"Since the request is validated as authorized an account should be known"
	accountId := aRestRequest accountId.
	connectionId := aRestRequest pathParameterAt: #id.

	"Validate connection exists"
	connectionExists := modelDatabase
		exists: #connectionExists
		statement: 'SELECT id FROM connections WHERE accountId=:accountId AND id=:connectionId'
		bind: {
			#accountId -> accountId.
			#connectionId -> connectionId } asDictionary.

	connectionExists ifFalse: [ CpNodeJSRestForbiddenError signal ]
]
