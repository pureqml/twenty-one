Image {
	property int points;
	width: 100s;
	height: 100s;
	source: "tip.png";

	Text {
		y: 27s;
		width: 100s;
		text: parent.points;
		font.pixelSize: 42s;
		horizontalAlignment: Text.AlignHCenter;
		color: "#fff";
	}
}
