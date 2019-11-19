from PySide2.QtCore import Property, Slot, Signal, QObject
import random, json

def listfill(list_, max, fill=0):
	list_ += [fill]*(max-len(list_))

class GamePlugin(QObject):
	"""docstring for GamePlugin."""
	def __init__(self):
		super(GamePlugin, self).__init__()
		self.playrecs = {"x": [], "o": []}
		self.records = []

	@Slot(str, int)
	def record(self, player, number):
		self.playrecs[player.lower()].append(number)
		self.records.append(number)

	@Slot(int)
	def newrecord(self, target):
		# make sure record have up to 9 items
		listfill(self.records, 9)

		# save old record
		self.records

		# put a empty list
		self.records = []
		self.playrecs["x"] = []
		self.playrecs["o"] = []

	@Slot(str)
	def checkwinner(self, player):
		wins = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
				[2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

		if len(self.playrecs[player.lower()]) > 2:
			for x in wins:
				if x[0] in self.playrecs[player.lower()] and x[1] in self.playrecs[player.lower()] and x[2] in self.playrecs[player.lower()]:
					return True
		return False

class BotPlugin(QObject):
	"""docstring for BotPlugin."""
	def __init__(self):
		super(BotPlugin, self).__init__()

	@Slot(str, result=int)
	def guess(self, alist):
		alist = json.loads(alist);
		x = random.choice(alist)
		return x
