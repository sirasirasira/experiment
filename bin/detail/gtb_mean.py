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
bound_count = 0

with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 0:
			model_num += 1
		elif i == 1:
			value = float(line)
			time += value
		elif i == 2:
			value = float(line.split()[3])
			feature += value
		elif i == 6:
			value = float(line.split()[3])
			acc += value
		elif i == 7:
			value = float(line.split()[3])
			auc += value
		elif i == 9:
			value = float(line.split()[3])
			cache_size += value
		elif i == 10:
			value = float(line.split()[3])
			gain_count += value
		elif i == 11:
			value = float(line.split()[3])
			bound_count += value
		i = (i+1) % 12

print("features size: ", feature/model_num)
print("test acc: ", acc/model_num)
print("test auc: ", auc/model_num)
print("cache size: ", cache_size/model_num)
print("gain count: ", gain_count/model_num)
print("bound count: ", bound_count/model_num)
print("time [s]: ", time/model_num)
