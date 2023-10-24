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
		// Don't process during delay
		if (opponentDelay.running)
			return

		// Call 'game over' event if both players are holding now or limit was reached
		if (this.opponentHold && this.playerHold || this.playerPoints > root.winLimit || this.opponentPoints > root.winLimit) {
			stackProto.gameOver()
			return
		}

		// Turn over if opponenet is holding
		if (this.opponentHold && this.playerMoved) {
			this.playerMoved = !this.playerMoved
			return
		}

		// Stop taking cards if opponent have more points and player is holding
		if (this.playerHold && this.opponentPoints > this.playerPoints) {
			this.opponentHold = true
			this.gameOver()
			return
		}

		// Keep opponent moving while player is holding
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

	shuffleArray(arr): {
		for (var i = arr.length - 1; i > 0; --i) {
			var j = Math.floor(Math.random() * (i + 1))
			var temp = arr[i]
			arr[i] = arr[j]
			arr[j] = temp
		}
	}

	fill: {
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
				cards.push({ suit: suits[s], number: i, points: points, xPosition: 0, yPosition: 0, rotation: 0 })
			}
		}
		this.shuffleArray(cards)
		cardsStack.model.assign(cards)

		this._last = cards.length - 1
		this.playerPoints = 0
		this.opponentPoints = 0
		this.playerHold = false
		this.opponentHold = false
		this.playerMoved = false
	}

	onCompleted: { this.fill() }
}
