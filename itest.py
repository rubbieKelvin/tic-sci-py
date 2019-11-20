import time, math

def fib(n):
	for i in range(math.factorial(n)):
		yield i

def fib2(n):
	c = []
	for i in range(math.factorial(n)):
		c.append(i)

def run1():
	start = time.time()
	c = fib(9)
	end = time.time()

	print("took", (end-start))

def run2():
	start = time.time()
	c = fib2(9)
	end = time.time()

	print("took", (end-start))
