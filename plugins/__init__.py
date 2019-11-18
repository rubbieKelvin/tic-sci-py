from PySide2.QtCore import Property, Slot, Signal, QObject
import random, json, threading
from sklearn.svm import SVC

# HOW THIS GOES
# score is set to 0:0
# all the buttons are reset to normal states
# player is requested to pick a button
# when player hits a button, he triggers the next player function which request the cumputer for a move
# the computer picks a move from the available buttons, and then triggers the next player function
# this goes on until all boxes are filled

# 11/17/2019 3:35am
# now that the app works, we'll start putting the rules
# valid takes =>
## 123
## 456
## 789
## 147
## 258
## 369
## 159
## 357

def int_list(list):
	res = []
	for i in list:
		res.append(int(i))
	return res

class Player:
	AI = 0
	HUMAN = 1


class GamePlugin(QObject):
	"""docstring for GamePlugin."""
	def __init__(self, file):
		super(GamePlugin, self).__init__()
		self.slots = list(range(1, 10))
		self.bot_slot = []
		self.player_slot = []
		self.file = file
		self.data = {
			"data":[],
			"target":[]
		}
		self.read_data()

	def read_data(self):
		with open(self.file) as file:
			self.data = json.load(file)
		self.model = SVC()
		self.model.fit(self.data["data"], self.data["target"])

	def learn(self, data, target):
		self.data["data"].append(data)
		self.data["target"].append(target)

	@Slot()
	def save(self):
		with open(self.file, "w") as file:
			json.dump(self.data, file)

	numberChosen = Signal(int, bool)	# fires when a player chooses a number
	slotReduced = Signal(int)
	playerWon = Signal(int)

	def check_winner(self):
		res = None
		wins = [
			[1, 2, 3],
			[4, 5, 6],
			[7, 8, 9],
			[1, 4, 7],
			[2, 5, 8],
			[3, 6, 9],
			[1, 5, 9],
			[3, 5, 7]
		]
		# check for human
		if len(self.player_slot) > 2:
			print("checking human", self.player_slot)
			for x in wins:
				if x[0] in self.player_slot and x[1] in self.player_slot and x[2] in self.player_slot:
					res = Player.HUMAN
					break

		# check for bot
		if len(self.bot_slot) > 2:
			print("checking bot", self.bot_slot)
			for x in wins:
				if x[0] in self.bot_slot and x[1] in self.bot_slot and x[2] in self.bot_slot:
					res = Player.AI
					break

		if res is not None:
			# learn from the game
			b = self.bot_slot+int_list(list("0"*(9-len(self.bot_slot))))
			h = self.player_slot+int_list(list("0"*(9-len(self.player_slot))))
			self.learn(b, int(res==Player.AI))
			self.learn(h, int(res==Player.HUMAN))
			self.playerWon.emit(res)
		else:
			h = self.player_slot+int_list(list("0"*(9-len(self.player_slot))))
			self.learn(h, 2)


	@Property(int, notify=slotReduced)
	def len_slot(self):
		return len(self.slots)

	@Slot(int, bool)
	def player_pick(self, number, toe):
		if number in self.slots:
			i = self.slots.index(number)
			self.player_slot.append(number)
			del self.slots[i]
			self.slotReduced.emit(len(self.slots))
			self.numberChosen.emit(number, toe)
			self.check_winner()

	def ai_pick(self):
		index = len(self.bot_slot)
		test = self.bot_slot.copy()
		num = None
		defence = None
		for i in range(10):
			test_2 = self.slots.copy()
			random.shuffle(test_2)
			c = test+(test_2[-2:])
			c = c+[0]*(9-len(c))

			pred = self.model.predict([c])
			print(c, pred)
			if int(pred)==1:
				num = c[index]
				break
			elif int(pred)==2:
				defence = c[index]

		if defence is not None:
			return defence
		return num

	@Slot(bool)
	def computer_pick(self, toe):
		num = random.choice(self.slots)
		test = self.bot_slot.copy()
		# predict here
		c = self.ai_pick()
		if c is not None: num = c
		print("final", num)

		# pick
		i = self.slots.index(num)
		self.bot_slot.append(num)
		del self.slots[i]

		# emit signal
		self.slotReduced.emit(len(self.slots))
		self.numberChosen.emit(num, toe)
		self.check_winner()

	@Slot()
	def reset(self):
		self.slots = self.slots = list(range(1, 10))
		self.bot_slot = []
		self.player_slot = []
		print("\n\n\n")
