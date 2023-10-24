Rectangle {
	signal restart;
	property bool playerWin;
	property bool tie;
	anchors.fill: parent;
	visible: false;
	color: "#000c";
	z: 100500;

	Text {
		id: gameOverText;
		y: 250s;
		anchors.horizontalCenter: parent.horizontalCenter;
		text: parent.tie ? "TIE" : (parent.playerWin ? "YOU WIN" : "YOU LOOSE");
		color: parent.tie ? "#FFEB3B" : (parent.playerWin ? "#43A047" : "#E53935");
		font.pixelSize: 64s;
	}

	TextButton {
		id: restartButton;
		anchors.top: gameOverText.bottom;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.topMargin: 50s;
		text: "RESTART";

		onPressed: { this.parent.restart() }
	}

	showDialog: {
		this.visible = true
		restartButton.setFocus()
	}

	hide: {
		this.visible = false
	}
}
