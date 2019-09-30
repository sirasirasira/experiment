import sys

args = sys.argv
filename = args[1]

model_num = 0
time = 0
feature = 0
acc = 0
auc = 0
cache_size = 0
gain_count = 0

with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 0:
			model_num += 1
		elif i == 1 or i == 2:
			value = float(line)
			time += value
		elif i == 3:
			value = float(line.split()[1])
			feature += value
		elif i == 4:
			value = float(line)
			acc += value
		elif i == 5:
			value = float(line)
			auc += value
		elif i == 6:
			value = float(line.split()[2])
			cache_size += value
		elif i == 7:
			value = float(line.split()[2])
			gain_count += value
		i = (i+1) % 8

print("features size: ", feature/model_num)
print("test acc: ", acc/model_num)
print("test auc: ", auc/model_num)
print("cache size: ", cache_size/model_num)
print("gain count: ", gain_count/model_num)
print("bound count: ", gain_count/model_num)
print("time [s]: ", time/model_num)
