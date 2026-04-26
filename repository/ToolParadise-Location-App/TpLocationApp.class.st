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

	CynPropertyEntity restApiClient hasAccessToken
		ifFalse: [ ^ self ].

	self loadData
]

{ #category : 'actions' }
TpLocationApp >> loadData [

	self loadDataConnections
]

{ #category : 'actions' }
TpLocationApp >> loadDataConnections [

	"Load data (make it failsafe when no data connection is available)"

	self traceCr: 'Reading connections'.
	[
		connections ifNil: [ connections := OrderedCollection new ].
		self dataMerge: (TplLocation restRead asOrderedCollection) into: connections
	] on: Error do: [ :err | self warnCr: 'Unable to read connections: ', err printString ]
]

{ #category : 'actions' }
TpLocationApp >> loadMenu [

	| menuStructure menuContentElement |

	super loadMenu.

	"Create (literal) structure with the menu items"
	menuStructure := {
		{ 'map-outline' . '#000' . TplMapPage . #'app.menu.map' }.
"		{ 'settings' . '#000' . TplPreferencesPage . #'app.menu.preferences' }."
		{ 'log-out-outline' . '#000' . TplLogoutPage . #'app.menu.logout' } }.

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
