Rectangle {
	signal pressed;
	property bool disabled;
	property string text;
	width: 150s;
	height: 50s;
	color: disabled ? "#424242" : "#F44336";
	radius: height / 2;
	border.width: activeFocus ? 3 : 0;
	border.type: Border.Outer;
	border.color: "#fff";
	focus: true;

	FocusOnHoverMixin { }
	ClickMixin { }

	Text {
		id: buttonText;
		anchors.centerIn: parent;
		text: parent.text;
		font.pixelSize: 34s;
		color: "#fff";
	}

	onClicked: { if (!this.disabled) this.pressed() }
	onSelectPressed: { if (!this.disabled) this.pressed() }
}
