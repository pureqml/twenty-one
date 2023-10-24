Rectangle {
	property bool playerWin;
	anchors.fill: parent;
	visible: false;
	color: "#000c";
	z: 100500;

	Text {
		id: gameOverText;
		text: parent.playerWin ? "YOU WIN" : "YOU LOOSE";
		color: parent.playerWin ? "#43A047" : "#E53935";
		anchors.centerIn: parent;
		font.pixelSize: 64s;
	}

	TextButton {
		id: restartButton;
		anchors.top: gameOverText.bottom;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.topMargin: 50s;
		text: "RESTART";
	}

	showDialog: {
		this.visible = true
		restartButton.setFocus()
	}

	hide: {
		this.visible = false
	}
}
