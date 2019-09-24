import sys

args = sys.argv
filename = args[1]

feature = 0
acc = 0
auc = 0
cache_size = 0
gain_count = 0
bound_count = 0

with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 1:
			value = float(line.split()[3])
			feature += value
		elif i == 5:
			value = float(line.split()[3])
			acc += value
		elif i == 6:
			value = float(line.split()[3])
			auc += value
		elif i == 8:
			value = float(line.split()[3])
			cache_size += value
		elif i == 9:
			value = float(line.split()[3])
			gain_count += value
		elif i == 10:
			value = float(line.split()[3])
			bound_count += value
		i = (i+1) % 11

print("features size: ", feature/10)
print("test acc: ", acc/10)
print("test auc: ", auc/10)
print("cache size: ", cache_size/10)
print("gain count: ", gain_count/10)
print("bound count: ", bound_count/10)

