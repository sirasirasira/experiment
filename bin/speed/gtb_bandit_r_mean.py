import sys

args = sys.argv
filename = args[1]

model_num = 0
time = 0
trainacc = 0
trainauc = 0
trainloss_mean = 0
testacc = 0
testauc = 0
testloss_mean = 0
feature = 0
cache_size = 0
gain_count = 0
bound_count = 0

with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 0:
			model_num += 1
		elif i == 1:
			value = float(line.split()[1])
			time += value
		elif i == 2:
			value = float(line.split()[1])
			trainacc += value
		elif i == 3:
			value = float(line.split()[1])
			trainauc += value
		elif i == 4:
			value = float(line.split()[1])
			trainloss_mean += value
		elif i == 5:
			value = float(line.split()[1])
			testacc += value
		elif i == 6:
			value = float(line.split()[1])
			testauc += value
		elif i == 7:
			value = float(line.split()[1])
			testloss_mean += value
		elif i == 8:
			value = float(line.split()[2])
			feature += value
		elif i == 9:
			value = float(line.split()[2])
			cache_size += value
		elif i == 10:
			value = float(line.split()[2])
			gain_count += value
		elif i == 11:
			value = float(line.split()[2])
			bound_count += value
		i = (i+1) % 12

time_mean = time/model_num
trainacc_mean = trainacc/model_num
trainauc_mean = trainauc/model_num
trainloss_mean_mean = trainloss_mean/model_num
testacc_mean = testacc/model_num
testauc_mean = testauc/model_num
testloss_mean_mean = testloss_mean/model_num
feature_mean = feature/model_num
cache_size_mean = cache_size/model_num
gain_count_mean = gain_count/model_num
bound_count_mean = bound_count/model_num

time_var = 0
trainacc_var = 0
trainauc_var = 0
trainloss_mean_var = 0
testacc_var = 0
testauc_var = 0
testloss_mean_var = 0
feature_var = 0
cache_size_var = 0
gain_count_var = 0
bound_count_var = 0

with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 1:
			value = float(line.split()[1])
			time_var += pow(time_mean - value, 2)
		elif i == 2:
			value = float(line.split()[1])
			trainacc_var += pow(trainacc_mean - value, 2)
		elif i == 3:
			value = float(line.split()[1])
			trainauc_var += pow(trainauc_mean - value, 2)
		elif i == 4:
			value = float(line.split()[1])
			trainloss_mean_var += pow(trainloss_mean_mean - value, 2)
		elif i == 5:
			value = float(line.split()[1])
			testacc_var += pow(testacc_mean - value, 2)
		elif i == 6:
			value = float(line.split()[1])
			testauc_var += pow(testauc_mean - value, 2)
		elif i == 7:
			value = float(line.split()[1])
			testloss_mean_var += pow(testloss_mean_mean - value, 2)
		elif i == 8:
			value = float(line.split()[2])
			feature_var += pow(feature_mean - value, 2)
		elif i == 9:
			value = float(line.split()[2])
			cache_size_var += pow(cache_size_mean - value, 2)
		elif i == 10:
			value = float(line.split()[2])
			gain_count_var += pow(gain_count_mean - value, 2)
		elif i == 11:
			value = float(line.split()[2])
			bound_count_var += pow(bound_count_mean - value, 2)
		i = (i+1) % 12

time_dev = pow(time_var / model_num, 0.5)
trainacc_dev = pow(trainacc_var / model_num, 0.5)
trainauc_dev = pow(trainauc_var / model_num, 0.5)
trainloss_mean_dev = pow(trainloss_mean_var / model_num, 0.5)
testacc_dev = pow(testacc_var / model_num, 0.5)
testauc_dev = pow(testauc_var / model_num, 0.5)
testloss_mean_dev = pow(testloss_mean_var / model_num, 0.5)
feature_dev = pow(feature_var / model_num, 0.5)
cache_size_dev = pow(cache_size_var / model_num, 0.5)
gain_count_dev = pow(gain_count_var / model_num, 0.5)
bound_count_dev = pow(bound_count_var / model_num, 0.5)

print("time:", time_mean, time_dev)
print("trainacc:", trainacc_mean, trainacc_dev)
print("trainauc:", trainauc_mean, trainauc_dev)
print("trainloss_mean:", trainloss_mean_mean, trainloss_mean_dev)
print("testacc:", testacc_mean, testacc_dev)
print("testauc:", testauc_mean, testauc_dev)
print("testloss_mean:", testloss_mean_mean, testloss_mean_dev)
print("features size:", feature_mean, feature_dev)
print("cache size:", cache_size_mean, cache_size_dev)
print("gain count:", gain_count_mean, gain_count_dev)
print("bound count:", bound_count_mean, bound_count_dev)
