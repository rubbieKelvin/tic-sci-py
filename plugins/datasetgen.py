import itertools, math, json, random

def checkwin(list_):
	wins = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
	for x in wins:
		if x[0] in list_ and x[1] in list_ and x[2] in list_:
			return True
	return False

def listfill(list_, max, fill=0):
	list_ += [fill]*(max-len(list_))

def generate(file):
	fac = math.factorial(9)

	possibilities = itertools.permutations([1, 2, 3, 4, 5, 6, 7, 8, 9])
	data = {"data":[], "target":[]}

	for _ in range(fac):
		i = list(next(possibilities))
		random.shuffle(i)
		zeros = random.choice([4, 5])
		i = i[:(10-zeros)]+([0]*(zeros-1))
		p1 = i[::2]
		p2 = i[1::2]

		if checkwin(p1):
			data["data"].append(i)
			data["target"].append(-1)
		elif checkwin(p2):
			data["data"].append(i)
			data["target"].append(1)
		else:
			data["data"].append(i)
			data["target"].append(0)

	# save
	with open(file, "w") as file_:
		json.dump(data, file_)

def generate2(num, file):

	data = {"data":[], "target":[]}

	def record(store, data, target):
		store["data"].append(data)
		store["target"].append(target)

	def play(source, feed, recorder=None):
		# print(f"play({source}, {feed}, {recorder})")
		x = random.choice(source)
		i = source.index(x)
		feed.append(x)
		del source[i]
		if recorder is not None: recorder.append(x)
		return x

	for i in range(num):
		slots = list(range(1, 10))
		rec = []
		xslots = []
		yslots = []
		won = False
		# print("round", i)

		while slots:
			# play x
			_ = play(slots, xslots, rec)
			# print("x plays", _)
			# check if x won
			if checkwin(xslots):
				listfill(rec, 9)
				record(data, rec, -1)
				# print("x won")
				won = True
				break

			# break if list is empty
			if not slots: break

			# play y
			_ = play(slots, yslots, rec)
			# print("y plays", _)
			# check if y won
			if checkwin(yslots):
				listfill(rec, 9)
				record(data, rec, 1)
				# print("y won")
				won = True
				break
		if not won:
			listfill(rec, 9)
			record(data, rec, 0)
			# print("nobody won")
		# print("\n\n")

	# save
	with open(file, "w") as file_:
		json.dump(data, file_)
