Class {
	#name : 'TpLocationApp',
	#superclass : 'CynAccountApp',
	#instVars : [
		'connections',
		'preferences'
	],
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'class initialization' }
TpLocationApp class >> beLoaded [

	CynText beLoaded.

	IonLabel beLoaded.
	IonText beLoaded.

	IonRefresher beLoaded.
	IonRefresherContent beLoaded.

	CpClassedAttributeDataUpdater beLoaded.
	CpStyleAttributeDataUpdater beLoaded.
	CpPropertyAttributeDataUpdater beLoaded.
	CpEventAttributeDataUpdater beLoaded.
	CpAnnouncementAttributeDataUpdater beLoaded.

	CpLeaflet
]

{ #category : 'class initialization' }
TpLocationApp class >> defaultFallbackLocales [

	^ self defaultLocale = #en
		ifTrue: [ #() ]
		ifFalse: [ #(en) ]
]

{ #category : 'class initialization' }
TpLocationApp class >> defaultLocale [

	| language |

	language := CpBrowserNavigator current language.

	language ifNil: [ ^ super defaultLocale ].

	"Extract language from locale"
	language := (language findTokens: '-') first.

	^ (TplPreferences languages includes: language)
		ifTrue: [ language ]
		ifFalse: [ super defaultLocale ]
]

{ #category : 'class initialization' }
TpLocationApp class >> globalStyle [

	<webResource: #css>

	^ super globalStyle, '
:root {
	--ion-color-primary: #FF487C;
	--ion-color-danger: #FA2A76;

	--canyon-label-color: #333;

	--location-color-primary: #FF487C;
	--location-color-secondary: #F7B32B;
	--location-color-medium: #45CFC5;
	--location-color-dark: #00006D;

	--location-background-color-primary: #FF487C4D;
	--location-background-color-secondary: #F7B32B40;
	--location-background-color-medium: #45CFC54C;
	--location-background-color-dark: #00006D33;
}
ion-menu ion-title {
	padding-inline-start: 10px;
	padding-inline-end: 10px;
	color: #00006D;
}
@media screen and (min-width: 940px) {
	body {
		transition: background-color 1s;
		background-color: var(--ion-background-color);
	}
	body.thin {
		background-color: #999;
	}
	ion-app {
		transition: left 1s, right 1s, background-color 1s;
	}
	html body.thin ion-app {
		left: calc((100% - 940px) / 2);
		right: calc((100% - 940px) / 2);
	}
}'
]

{ #category : 'accessing' }
TpLocationApp class >> version [

	^ 'v0.0.1'
]

{ #category : 'accessing' }
TpLocationApp >> connections [

	^ connections
]

{ #category : 'accessing' }
TpLocationApp >> currentLocale [

	^ self preferredLanguage ifNil: [ self class defaultLocale ]
]

{ #category : 'private' }
TpLocationApp >> dataMerge: newCollection into: existingCollection [

	| existingIndex existingItem |

	"Create or update elements from the new collection into the existing collection"
	newCollection withIndexDo: [ :eachNew :newIndex |
		existingIndex := existingCollection findFirst: [ :eachExisting | eachExisting id = eachNew id ].
		existingIndex > 0
			ifTrue: [
				"Move the existing into the new position"
				existingItem := existingCollection add: (existingCollection removeAt: existingIndex) beforeIndex: newIndex.

				"Merge the content of the new element into the existing one"
				existingItem merge: eachNew ]
			ifFalse: [
				"Add the new into the new position"
				existingCollection add: eachNew beforeIndex: newIndex ] ].

	"Remove any remaining elements"
	[ existingCollection size > newCollection size ] whileTrue: [
		existingCollection removeLast ]
]

{ #category : 'accessing' }
TpLocationApp >> firstConnection [

	^ connections
		ifNotEmpty: [ connections first ]
		ifEmpty: [ nil ]
]

{ #category : 'event handling' }
TpLocationApp >> handleSelectMenuItem: aClickEvent [

	| pageClassName |

	pageClassName := (aClickEvent currentTarget id) withoutPrefix: #'menu-'.

	self menuClose.

	(Smalltalk classNamed: pageClassName) ifNotNil: [ :pageClass |
		self navigateTo: pageClass ]
]

{ #category : 'accessing' }
TpLocationApp >> homePageClass [

	^ connections size = 1
		ifTrue: [ TplMapPage ]
		ifFalse: [ TplConnectionsPage ]
]

{ #category : 'initialization' }
TpLocationApp >> initialize [

	super initialize.

	account propertyAt: #expires put: #never.

	preferences := TplPreferences new.

	CynPropertyEntity restApiClient hasAccessToken
		ifFalse: [ ^ self ].

	self loadData
]

{ #category : 'actions' }
TpLocationApp >> loadData [

	self
		loadDataUserPreferences ;
		loadDataConnections
]

{ #category : 'actions' }
TpLocationApp >> loadDataConnections [

	"Load data (make it failsafe when no data connection is available)"

	self traceCr: 'Reading connections'.
	[
		connections ifNil: [ connections := OrderedCollection new ].
		self dataMerge: (TplConnection restRead asOrderedCollection) into: connections
	] on: Error do: [ :err | self warnCr: 'Unable to read connections: ', err printString ]
]

{ #category : 'actions' }
TpLocationApp >> loadDataUserPreferences [

	"Load data (make it failsafe when no data connection is available)"

	| all |

	self traceCr: 'Reading user preferences'.
	[
		all := TplPreferences restRead.
		preferences merge: all first.

		"Now we know the preferred language, update it"
		self updateCurrentLanguage.
	] on: Error do: [ :err | self warnCr: 'Unable to read user preferences: ', err printString ]
]

{ #category : 'actions' }
TpLocationApp >> loadMenu [

	| menuStructure menuContentElement |

	super loadMenu.

	"Create (literal) structure with the menu items"
	menuStructure := {
		{ 'map-outline' . '#FF487C' . TplMapPage . #'app.menu.map' }.
		{ 'settings' . '#F7B32B' . TplPreferencesPage . #'app.menu.preferences' }.
		{ 'log-out-outline' . '#45CFC5' . TplLogoutPage . #'app.menu.logout' } }.

	menuContentElement := IonContent new
		appendChild: (IonList new
			attributeAt: #inset put: #false ;
			yourself) ;
		yourself.

	menuStructure do: [ :each |
		menuContentElement appendChild: (IonItem new
			id: #'menu-', each third name ;
			href: each first ;
			detail: false ;		"prevent showing the chevron-right"
			appendChild: ((IonIcon named: each first)
				styleAt: #color put: each second ;
				yourself) atSlotNamed: #start ;
			appendChild: (CynText text: each fourth) ;
			when: CpClickEvent deferSend: #handleSelectMenuItem: to: self ;
			fullStopWhen: CpClickEvent ;
			yourself) ].

	menu appendChild: menuContentElement.
	(menu firstDescendantMatching: IonTitle asCssSelector) ifNotNil: [ :title |
		title textContent: 'TP Location Viewer'.
		title parent
			insertChild: (CpLoadResource new
				id: #'menu-logo' ;
				src: 'img/logo.png' ;
				yourself)
			before: title
			atSlotNamed: #start ]
]

{ #category : 'actions' }
TpLocationApp >> logout [

	account logout.

	navigation children reverseDo: [ :each |
		each destroy ].

	self showLogin.

	"After login load data"
	self loadData.

	"Load the initial page"
	self showInitialPage
]

{ #category : 'accessing' }
TpLocationApp >> menuSide [

	"Answer the side where the menu is shown (either #start or #end)"

	^ #end
]

{ #category : 'actions' }
TpLocationApp >> performUpdateVersion [

	self
		confirm: #'app.confirm.title.update.version' langText
		action: #'app.confirm.action.update.version' langText
		onConfirm: [ CpBrowserDocument current location reload ]
]

{ #category : 'accessing' }
TpLocationApp >> preferredLanguage [

	^ preferences ifNotNil: [ preferences language ]
]

{ #category : 'actions' }
TpLocationApp >> showInitialPage [

	self showPageFromUrl.

	"If no page shown using URL, show regular initial page (with a logged in user)"
	self activePage ifNil: [
		account isLoggedIn
			ifFalse: [ self showLogin ].
		super showInitialPage ]
]

{ #category : 'actions' }
TpLocationApp >> showLogin [

	self showModal: TplLoginAccountPage withModel: account.

	account isLoggedIn
		ifTrue: [ self loadData ]
		ifFalse: [ self showLogin ]
]

{ #category : 'actions' }
TpLocationApp >> showPage: aPageClass withModel: aModel [

	"Show the specified Page with the (optional) Model.
	It is assumed, that all checks have already been performed with respect to navigation.
	Answer the page shown."

	"Check if a similar (main) page is already open and re-use it"
	aPageClass isMainPage
		ifTrue: [
			navigation children do: [ :each |
				each class = aPageClass
					ifTrue: [

						"Update the model"
						each model: aModel.

						"Bring page to front"
						self makeTopPage: each.

						^ each ] ] ].

	^ super showPage: aPageClass withModel: aModel
]
