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
	CpAnnouncementAttributeDataUpdater beLoaded
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

{ #category : 'as yet unclassified' }
TpLocationApp class >> tplViewTextsEn [

	"Answer view texts"

	<languageResource: #en>

	^ Dictionary new
		at: #'app.short.date' put: '{dayOfWeekName} {day} {monthName}' ;
		at: #'app.page.title.account.login' put: 'Welcome' ;
		at: #'app.page.title.account.register' put: 'New account' ;
		at: #'app.page.title.account.activate' put: 'Account' ;
		at: #'app.page.title.account.passwordForgotten' put: 'Change password' ;
		at: #'app.page.title.account.passwordReset' put: 'Change password' ;
		at: #'app.page.title.map' put: 'Map' ;
		at: #'app.page.title.connections' put: 'Connections' ;
		at: #'app.page.title.preferences' put: 'Preferences' ;
		at: #'app.page.title.logout' put: 'Logout' ;
		at: #'app.label.account.email' put: 'Email' ;
		at: #'app.label.account.password' put: 'Password' ;
		at: #'app.label.activateAccountToken.token' put: 'Code' ;
		at: #'app.label.changePasswordToken.token' put: 'Code' ;
		at: #'app.label.changePasswordToken.password' put: 'New password' ;
		at: #'app.label.preferences.locationId' put: 'Default location' ;
		at: #'app.label.preferences.language' put: 'Language' ;
		at: #'app.selection.preferences.language.en' put: 'English' ;
		at: #'app.selection.preferences.language.nl' put: 'Nederlands' ;
		at: #'app.label.audigram.score.ask' put: 'Please score:' ;
		at: #'app.selection.loginAccount.expires.usage' put: 'After usage' ;
		at: #'app.selection.loginAccount.expires.day' put: 'The next day' ;
		at: #'app.selection.loginAccount.expires.never' put: 'Never' ;
		at: #'app.placeholder.account.email' put: 'name@domain.org' ;
		at: #'app.placeholder.account.token' put: '92cd8b57 <example code> 3f04597a' ;
		at: #'app.link.account.register' put: 'Create account' ;
		at: #'app.link.account.passwordForgotten' put: 'Change password' ;
		at: #'app.button.label.generic.done' put: 'Done' ;
		at: #'app.button.label.generic.cancel' put: 'Cancel' ;
		at: #'app.button.label.generic.edit' put: 'Edit' ;
		at: #'app.button.label.account.login' put: 'Login' ;
		at: #'app.button.label.account.register' put: 'Create' ;
		at: #'app.button.label.account.activate' put: 'Activate account' ;
		at: #'app.button.label.account.passwordForgotten' put: 'Send mail' ;
		at: #'app.button.label.account.passwordReset' put: 'Change password' ;
		at: #'app.button.label.logout.back' put: 'Oops, go back' ;
		at: #'app.button.label.logout.do' put: 'Logout now' ;
		at: #'app.form.violations' put: 'Not all input is usable for TP Location.' ;
		at: #'app.form.violations.check.fields' put: (Dictionary new
			at: 1 put: 'Please check the field' ;
			at: #default put: 'Please check the fields' ;
			yourself) ;
		at: #'app.action.title.form.changes' put: 'There are unstored changes' ;
		at: #'app.action.button.save' put: 'Store my changes first' ;
		at: #'app.action.button.ignore' put: 'Ignore my changes' ;
		at: #'app.action.button.cancel' put: 'Cancel' ;
		at: #'app.loading.account.login' put: 'Logging in...' ;
		at: #'app.loading.account.register' put: 'Register account...' ;
		at: #'app.loading.account.activate' put: 'Activate account...' ;
		at: #'app.loading.account.passwordForgotten' put: 'Sending mail...' ;
		at: #'app.loading.account.passwordReset' put: 'Changing password...' ;
		at: #'app.alert.title.account.register.conflict' put: 'Registration not successful' ;
		at: #'app.alert.message.account.register.conflict' put: 'Unfortunately, the specified email address is not recognised as belonging to an allowed user. Please contact your organisation or the maintainer to sort this out.' ;
		at: #'app.alert.title.account.login.failed' put: 'Login not successful' ;
		at: #'app.alert.message.account.login.failed' put: 'The combination email and password is unknown.' ;
		at: #'app.alert.message.account.login.inactive' put: 'Your account is not activated yet. Please activate it using the link in the email you received. If you have not received this email, please contact the maintainer.' ;
		at: #'app.alert.title.account.register.success' put: 'Account created' ;
		at: #'app.alert.message.account.register.success' put: 'A mail will be sent to the specified email address containing an activation link. Please open your mail and use that link to activate your account.' ;
		at: #'app.alert.title.account.activate.success' put: 'Activation done' ;
		at: #'app.alert.message.account.activate.success' put: 'A mail confirming the activation should arrive shortly in your mailbox. This page will close and bring you back to the starting page.' ;
		at: #'app.alert.title.account.activate.failed' put: 'Activation failed' ;
		at: #'app.alert.message.account.activate.token' put: 'The specified code is unknown. Please create the account again to receive a new activation code.' ;
		at: #'app.alert.message.account.activate.expired' put: 'The specified code has expired. Please create the account again to receive a new activation code.' ;
		at: #'app.alert.title.account.passwordReset.success' put: 'Password changed' ;
		at: #'app.alert.message.account.passwordReset.success' put: 'A mail confirming the password change should arrive shortly in your mailbox. This page will close and bring you back to the starting page.' ;
		at: #'app.alert.title.account.passwordReset.failed' put: 'Change password failed' ;
		at: #'app.alert.message.account.passwordReset.token' put: 'The specified code is unknown. Please request another change of password to receive a new code.' ;
		at: #'app.alert.message.account.passwordReset.expired' put: 'The specified code has expired. Please request another change of password to receive a new code.' ;
		at: #'app.alert.title.account.passwordReset' put: 'Password change' ;
		at: #'app.alert.message.account.passwordReset' put: 'A mail will be sent to the specified email address containing a special link. Please open your mail and use that link to change your password.' ;
		at: #'app.alert.title.token.invalid' put: 'The code is invalid' ;
		at: #'app.alert.message.token.invalid' put: 'The code from the link is invalid. Is the link accidentally not copied in full from the mail? Please try using the link from the mail again. This page will be closed.' ;
		at: #'app.alert.title.remove.last.location' put: 'Can''t remove' ;
		at: #'app.alert.message.remove.last.location' put: 'This is the only remaining location.' ;
		at: #'app.alert.title.remove.non-empty.location' put: 'Can''t remove' ;
		at: #'app.alert.message.remove.non-empty.location' put: 'This location still has residents. Please move them to another location first.' ;
		at: #'app.confirm.title.update.version' put: 'A new version of TP Location is available' ;
		at: #'app.confirm.action.update.version' put: 'Start new version' ;
		at: #'app.toast.changes.ignored' put: 'Changes not stored' ;
		at: #'app.toast.saveOnNavigate.failed' put: 'Can not save changes' ;
		at: #'app.note.account.activate.action' put: 'Please press the button below to activate your acount.' ;
		at: #'app.note.account.passwordForgotten.action' put: 'Please enter the email address you use for your TP Location account and then press the button "send email" in the top right corner. You will receive an email from TP Location on the given email address. With that email you can then change the password for your account.' ;
		at: #'app.note.account.passwordReset.action' put: 'Please enter a new password specific for the TP Location app and then press the button below to store that password with your account.' ;
		at: #'app.note.account.register.action' put: 'Please enter your email address and a new password specific for the TP Location app. Press the "create" button in the top right corner to create your account. The password needs to be at least 8 characters long. After creation you will receive an email from TP Location on the given email address. With that email you can then activate your new account and get started with the TP Location app!' ;
		at: #'app.menu.today' put: 'Today' ;
		at: #'app.menu.map' put: 'Map' ;
		at: #'app.menu.connections' put: 'Connections' ;
		at: #'app.menu.preferences' put: 'Preferences' ;
		at: #'app.menu.logout' put: 'Logout' ;
		yourself
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
