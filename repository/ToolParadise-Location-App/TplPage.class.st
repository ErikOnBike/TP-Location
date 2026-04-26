Class {
	#name : 'TplPage',
	#superclass : 'CynPage',
	#category : 'ToolParadise-Location-App-View',
	#package : 'ToolParadise-Location-App',
	#tag : 'View'
}

{ #category : 'tags' }
TplPage class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : 'testing' }
TplPage class >> isMainPage [

	"Answer whether the receiver is a main page"

	^ false
]

{ #category : 'web resources' }
TplPage class >> style [

	<webResource: #css>

	^ super style, '
ion-header.ion-no-border {
	background-color: #fff;
}
ion-header.ion-no-border ion-toolbar::part(background) {
	background-color: #99E3DE;
}
#header-bottom {
	position: absolute;
	width: 100%;
	height: 20px;
	stroke: #99E3DE;;
	fill: #99E3DE;
}
ion-content {
	--padding-top: 20px;
}
ion-title {
	font-family: "DM Sans";
	font-size: 24px;
	color: #00006D;
}
ion-note.ion-margin-horizontal {
	display: block;
	margin-top: 10px;
}
#form {
	margin-bottom: 10px;
}
a {
	cursor: pointer;
}
:host ion-item ion-input div.native-wrapper input.native-input {
	padding-top: 3px;
	padding-bottom: 3px;
}
:host ion-item ion-input input.native-input {
	background-color: rgba(255, 255, 255, .3);
}
:host ion-item ion-input.ion-invalid.ion-touched:not(.has-focus) input {
	background: linear-gradient(90deg, rgba(255, 0, 0, .1), rgba(255, 0, 0, 0));
}
:host ion-item ion-input .input-bottom,
:host ion-item ion-textarea .textarea-bottom {
	border-top: none;
	padding-top: 0;
	transition: padding .2s, min-height .2s;
}
:host ion-item ion-input:not(.ion-invalid) .input-bottom,
:host ion-item ion-textarea:not(.ion-invalid) .textarea-bottom {
	height: 0;
}
:host ion-item ion-input.filling.has-focus .input-bottom,
:host ion-item ion-textarea.filling.has-focus .textarea-bottom {
	padding-top: 5px;
	min-height: 25px;
}
:host ion-item ion-input:not(.has-focus) .input-bottom .counter,
:host ion-item ion-textarea:not(.has-focus) .textarea-bottom .counter {
	display: none;
}
/* Fix for older iOS versions */
.ion-color-danger {
	--ion-color-base: #FA2A76;
	color: white;
}'
]

{ #category : 'view' }
TplPage >> documentTitleFrom: aString [

	^ aString
		ifNotNil: [
			aString = #Location
				ifTrue: [ aString ]
				ifFalse: [ 'Location - ', aString ] ]
		ifNil: [ #Location ]
]

{ #category : 'testing' }
TplPage >> isMainPage [

	"Answer whether the receiver is a main page"

	^ self class isMainPage
]

{ #category : 'view' }
TplPage >> toolbarEndButtons [

	self isModelPage
		ifTrue: [ ^ super toolbarEndButtons ].

	^ self activeChildView
		ifNotNil: [ :activeChildView | activeChildView toolbarEndButtons ]
		ifNil: [
			self isShownInModal
				ifTrue: [  #() ]
				ifFalse: [ Array with: IonMenuButton new ] ]
]
