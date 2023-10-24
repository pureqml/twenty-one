Item {
	id: stackProto;
	signal gameOver;
	property int playerPoints;
	property int opponentPoints;
	property bool playerHold;
	property bool opponentHold;
	property bool playerMoved;
	width: 200s;
	height: 200s;
	anchors.right: parent.right;
	anchors.verticalCenter: parent.verticalCenter;
	anchors.bottomMargin: -100s;
	anchors.rightMargin: 100s;

	ClickMixin { }

	Repeater {
		id: cardsStack;
		model: ListModel {}
		delegate: Card {}

		onCountChanged: { this.parent._last = value - 1 }
	}

	Timer {
		id: opponentDelay;
		interval: 500;

		onTriggered: { this.parent.opponentMove() }
	}

	opponentMove: {
		if (stackProto.opponentPoints >= 17)
			this.opponentHold = true
		this.takeAnotherCard()
	}

	takeAnotherCard: {
		if (this.opponentHold && this.playerHold) {
			log("Game over")
			stackProto.gameOver()
			return
		}

		// if (opponentDelay.running)
		// 	return

		if (this._last < 0)
			return


		if (this.opponentHold && this.playerMoved) {
			this.playerMoved = !this.playerMoved
			return
		}

		if (this.playerHold) {
			this.playerMoved = true
		}

		var idx = this._last
		var rest = cardsStack.count - this._last
		var model = cardsStack.model
		var row = model.get(idx)
		var scale = this._context.virtualScale
		model.setProperty(idx, "turnedOver", true)
		model.setProperty(idx, "zLayer", rest)
		model.setProperty(idx, "rotation", Math.floor(Math.random() * 10) - 5)
		model.setProperty(idx, "xPosition", (-700 + rest * 40) * scale)
		if (this.playerMoved) {
			model.setProperty(idx, "yPosition", -200 * scale)
			stackProto.opponentPoints += row.points
		} else {
			model.setProperty(idx, "yPosition", 250 * scale)
			stackProto.playerPoints += row.points
		}

		this.playerMoved = !this.playerMoved
		--this._last

		if (this.playerMoved || this.playerHold) {
			opponentDelay.restart()
		}
	}

	// onClicked: { this.takeAnotherCard() }

	shuffleArray(arr): {
		for (var i = arr.length - 1; i > 0; --i) {
			var j = Math.floor(Math.random() * (i + 1))
			var temp = arr[i]
			arr[i] = arr[j]
			arr[j] = temp
		}
	}

	onCompleted: {
		var cards = [ ]
		var suits = [ "hearts", "spades", "diamonds", "clubs" ]
		for (var s in suits) {
			for (var i = 2; i < 15; ++i) {
				var points = i
				if (i > 10) {
					switch (i) {
						case 11: points = 2; break
						case 12: points = 3; break
						case 13: points = 4; break
						case 14: points = 11; break
					}
				}
				cards.push({ suit: suits[s], number: i, points: points })
			}
		}
		this.shuffleArray(cards)
		cardsStack.model.assign(cards)
	}
}
