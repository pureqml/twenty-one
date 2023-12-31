Rectangle {
	id: root;
	property int winLimit: 21;
	anchors.fill: context;
	color: "#2E7D32";

	Item {
		width: 1280s;
		height: 720s;

		PointsText {
			id: opponentPoints;
			x: 150s;
			y: 100s;
			points: cards.opponentPoints;
			z: gameOverDialog.z + 1;
		}

		PointsText {
			id: playerPoints;
			x: 150s;
			anchors.bottom: parent.bottom;
			anchors.bottomMargin: 100s;
			points: cards.playerPoints;
			z: gameOverDialog.z + 1;
		}

		CardsStack {
			id: cards;

			onPlayerPointsChanged: {
				if (value > root.winLimit)
					gameOverDialog.showDialog()
			}

			onOpponentPointsChanged: {
				if (value > root.winLimit)
					gameOverDialog.showDialog()
			}

			onGameOver: { gameOverDialog.showDialog() }
		}

		Column {
			anchors.top: cards.bottom;
			anchors.horizontalCenter: cards.horizontalCenter;
			anchors.topMargin: 100s;
			anchors.rightMargin: -50s;
			spacing: 30s;

			TextButton {
				id: hitButton;
				text: "HIT";

				onPressed: { cards.takeAnotherCard() }
			}

			TextButton {
				id: standButton;
				text: "STAND";

				onPressed: {
					cards.playerHold = true
					cards.takeAnotherCard()
					hitButton.disabled = true
					this.disabled = true
				}
			}
		}
	}

	GameOver {
		id: gameOverDialog;
		playerWin: cards.playerPoints <= root.winLimit && cards.playerPoints > cards.opponentPoints || cards.opponentPoints > root.winLimit;
		tie: cards.playerPoints == cards.opponentPoints;

		onRestart: {
			this.hide()
			hitButton.disabled = false
			standButton.disabled = false
			cards.fill()
		}
	}

	onCompleted: {
		hitButton.setFocus()
	}
}
