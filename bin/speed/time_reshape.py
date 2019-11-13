import sys

args = sys.argv
filename = args[1]

time = 0

with open(filename, "r") as f:
	for line in f:
		time += float(line)

print("time:", time)
