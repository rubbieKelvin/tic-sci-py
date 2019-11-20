from PySide2.QtCore import Property, Slot, Signal, QObject
import random, json, pickle, itertools, math, threading
from .datasetgen import checkwin
from joblib import dump

def listfill(list_, max_, fill=0):
	if len(list_) != max_:
		list_ += [fill]*(max_-len(list_))

# def list_to_int(list_):
# 	list_ = list.copy()
# 	res = ""
# 	for i in list_:
# 		res += str(i)
# 	return int(res)
#
# def int_to_list(int_):
# 	return list(str(int_))


class GamePlugin(QObject):
	"""docstring for GamePlugin."""
	def __init__(self):
		super(GamePlugin, self).__init__()
		self.playrecs = {"x": [], "o": []}
		self.records = []
		self.bot = None

	def teach(self, data, target):
		if self.bot is not None:
			self.bot.train(data, target)

	@Slot(str, int)
	def record(self, player, number):
		self.playrecs[player.lower()].append(number)
		self.records.append(number)

	@Slot()
	def reset(self):
		# put a empty list
		self.records = []
		self.playrecs["x"] = []
		self.playrecs["o"] = []

	@Slot(int)
	def newrecord(self, target):
		# make sure record have up to 9 items
		listfill(self.records, 9)

		# save old record
		self.teach(self.records, target)

		# put a empty list
		self.records = []
		self.playrecs["x"] = []
		self.playrecs["o"] = []

	@Slot(str, result=bool)
	def checkwinner(self, player):
		wins = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
				[2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
		res = False

		# if len(self.playrecs[player.lower()]) > 2:
		for x in wins:
			if x[0] in self.playrecs[player.lower()] and x[1] in self.playrecs[player.lower()] and x[2] in self.playrecs[player.lower()]:
				res = True
				break
		print(f"checking for player {player}, moves={self.playrecs[player.lower()]} win={res}")
		return res

class BotPlugin(QObject):
	"""docstring for BotPlugin."""
	def __init__(self, model, filename, gameplugin):
		super(BotPlugin, self).__init__()
		self.model = model
		self.filename = filename
		self.gameplugin = gameplugin

	def train(self, data, target):
		print("fitting data into model:", [data], [target])
		self.model.partial_fit([data], [target])

	@Slot(str, result=int)
	def guess(self, alist):
		alist = json.loads(alist)
		plist = self.gameplugin.records

		num = random.choice(alist)
		alt = None

		# print(plist,"+",alist)
		print(f"{math.factorial(len(alist))} possibilities")

		if len(plist) > 1:
			# perm = itertools.permutations(alist)
			for i in list(itertools.permutations(alist)):
				i_ = plist.copy()
				i_+=i

				pred = self.model.predict([i_])

				if pred == 1:
					# if it gets a good score at prediction, use
					y = i_[1::2]
					score = self.model.score([i_], [int(checkwin(y))])
					if score > 0.5:
						print("cool move:", i[0])
						return i[0]
				elif pred == -1:
					x = i_[::2]
					score = self.model.score([i_], [int(checkwin(x))*-1])
					if score > 0.9:
						# check player's move for counter
						for p in i:
							c_ = checkwin(self.gameplugin.playrecs['x'].copy()+[p])
							if c_:
								print("counter movement:", p)
								return p
				elif pred == 0:
					# print(i_, i, i[1])
					num = i[0]

		print("couldnt find a winning move".upper())
		return num

	def save_model_(self):
		dump(self.model, self.filename)
		# self.savingDataEnded.emit()

	@Slot()
	def save_model(self):
		# self.savingDataStarted.emit()
		threading.Thread(target=self.save_model_).start()
		# self.save_model_()
