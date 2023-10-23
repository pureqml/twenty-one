Rectangle {
	signal pressed;
	property string text;
	// width: buttonText.width + 20s;
	width: 150s;
	height: 50s;
	color: "#F44336";
	radius: height / 2;
	border.width: activeFocus ? 3 : 0;
	border.type: Border.Outer;
	border.color: "#fff";

	FocusOnHoverMixin { }
	ClickMixin { }

	Text {
		id: buttonText;
		anchors.centerIn: parent;
		// anchors.verticalCenter: parent.verticalCenter;
		text: parent.text;
		font.pixelSize: 34s;
		color: "#fff";
	}

	onClicked: { this.pressed() }
	onSelectPressed: { this.pressed() }
}
