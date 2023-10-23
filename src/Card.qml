Image {
	property int cardNumber: model.number;
	property string suit: model.suit;
	property bool opened: model.turnedOver;
	x: model.index * 0.5;
	y: model.index * 0.5;
	width: 120s;
	height: 169s;
	source: opened ? "cards/" + suit + "/" + cardNumber + ".png" : "back.png";
	horizontalAlignment: Image.AlignLeft;
	transform.translateX: model.xPosition;
	transform.translateY: model.yPosition;
	transform.rotate: model.rotation;
	radius: 10s;
	z: model.zLayer;

	Behavior on transform { Animation { duration: 500; } }
}
