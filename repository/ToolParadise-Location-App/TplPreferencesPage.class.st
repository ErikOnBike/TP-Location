Class {
	#name : 'TplPreferencesPage',
	#superclass : 'TplPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'accessing' }
TplPreferencesPage class >> defaultModel [

	^ self app preferences
]

{ #category : 'testing' }
TplPreferencesPage class >> isMainPage [

	^ true
]

{ #category : 'testing' }
TplPreferencesPage class >> isModelPage [

	^ true
]

{ #category : 'web resources' }
TplPreferencesPage class >> template [

	<webResource: #html>

	^ '<ion-header>
	<ion-toolbar>
		<ion-title><cyn-text text="app.page.title.preferences"></cyn-text></ion-title>
	</ion-toolbar>
</ion-header>
<ion-content>
	<ion-refresher id="refresher" slot="fixed">
		<ion-refresher-content></ion-refresher-content>
	</ion-refresher>
	<div id="container">
		<h1 id="name-text"></h1>
		<form id="form">
			<ion-list>
				<ion-item>
					<ion-select id="locationId" label-placement="stacked" interface="action-sheet"></ion-select>
				</ion-item>
				<ion-item>
					<ion-select id="language" label-placement="stacked" interface="action-sheet"></ion-select>
				</ion-item>
			</ion-list>
		</form>
	</div>
</ion-content>'
]

{ #category : 'binding' }
TplPreferencesPage >> addBindings [

	super addBindings.

	self addBinding: (model when: (CynPropertyChanged name: #language) send: #languageChanged: to: self)
]

{ #category : 'binding' }
TplPreferencesPage >> boundProperties [

	^ super boundProperties,
		#(locationId language)
]

{ #category : 'event handling' }
TplPreferencesPage >> handleRefreshAction [

	CpBrowserDocument current location reload
]

{ #category : 'event handling' }
TplPreferencesPage >> languageChanged: aPropertyChanged [

	| language |

	language := aPropertyChanged newValue
		ifNotNil: [ :newValue | newValue asSymbol ].

	(TplPreferences languages includes: language)
		ifFalse: [ ^ self ].

	CynApp updateLanguage: (CynApp languageWithLocale: language)
]

{ #category : 'view' }
TplPreferencesPage >> navigateBack [

	super navigateBack.

	self app updateCurrentLanguage
]
