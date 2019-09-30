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
			value = float(line.split()[2])
			feature += value
		elif i == 2:
			value = float(line.split()[2])
			acc += value
		elif i == 3:
			value = float(line.split()[2])
			auc += value
		elif i == 4:
			value = float(line.split()[2])
			cache_size += value
		elif i == 5:
			value = float(line.split()[2])
			gain_count += value
		elif i == 6:
			value = float(line.split()[2])
			bound_count += value
		elif i == 7:
			value = float(line.split()[2])
			time += value
		i = (i+1) % 8

feature_mean = feature/model_num
acc_mean = acc/model_num
auc_mean = auc/model_num
cache_size_mean = cache_size/model_num
gain_count_mean = gain_count/model_num
bound_count_mean = bound_count/model_num
time_mean = time/model_num

feature_var = 0
acc_var = 0
auc_var = 0
cache_size_var = 0
gain_count_var = 0
bound_count_var = 0
time_var = 0

with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 1:
			value = float(line.split()[2])
			feature_var += pow(feature_mean - value, 2)
		elif i == 2:
			value = float(line.split()[2])
			acc_var += pow(acc_mean - value, 2)
		elif i == 3:
			value = float(line.split()[2])
			auc_var += pow(auc_mean - value, 2)
		elif i == 4:
			value = float(line.split()[2])
			cache_size_var += pow(cache_size_mean - value, 2)
		elif i == 5:
			value = float(line.split()[2])
			gain_count_var += pow(gain_count_mean - value, 2)
		elif i == 6:
			value = float(line.split()[2])
			bound_count_var += pow(bound_count_mean - value, 2)
		elif i == 7:
			value = float(line.split()[2])
			time_var += pow(time_mean - value, 2)
			time += value
		i = (i+1) % 8

feature_dev = pow(feature_var / model_num, 0.5)
acc_dev = pow(acc_var / model_num, 0.5)
auc_dev = pow(auc_var / model_num, 0.5)
cache_size_dev = pow(cache_size_var / model_num, 0.5)
gain_count_dev = pow(gain_count_var / model_num, 0.5)
bound_count_dev = pow(bound_count_var / model_num, 0.5)
time_dev = pow(time_var / model_num, 0.5)

print("features size: ", feature_mean, feature_dev)
print("test acc: ", acc_mean, acc_dev)
print("test auc: ", auc_mean, auc_dev)
print("cache size: ", cache_size_mean, cache_size_dev)
print("gain count: ", gain_count_mean, gain_count_dev)
print("bound count: ", bound_count_mean, bound_count_dev)
print("time [s]: ", time_mean, time_dev)
