Rectangle {
	width: 1280s;
	height: 720s;
	color: "#2E7D32";

	PointsText {
		id: opponentPoints;
		x: 150s;
		y: 100s;
		points: cards.opponentPoints;
	}

	PointsText {
		id: playerPoints;
		x: 150s;
		anchors.bottom: parent.bottom;
		anchors.bottomMargin: 100s;
		points: cards.playerPoints;
	}

	CardsStack {
		id: cards;
	}

	Column {
		anchors.top: cards.bottom;
		anchors.horizontalCenter: cards.horizontalCenter;
		anchors.topMargin: 100s;
		anchors.rightMargin: -50s;
		spacing: 30s;

		TextButton {
			text: "HIT";

			onPressed: { cards.takeAnotherCard() }
		}

		TextButton {
			text: "STAND";

			onPressed: {
				cards.playerHold = true
				cards.takeAnotherCard()
			}
		}
	}
}
