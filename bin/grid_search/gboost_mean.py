import sys

args = sys.argv
filename = args[1]

model_num = 0
acc = 0
auc = 0
with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 0:
			model_num += 1
		elif i == 1:
			value = float(line)
			acc += value
		elif i == 2:
			value = float(line)
			auc += value
		i = (i+1) % 3
acc_mean = acc/model_num
auc_mean = auc/model_num

acc_var = 0
auc_var = 0
with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 1:
			value = float(line)
			acc_var += pow(acc_mean - value, 2)
		elif i == 2:
			value = float(line)
			auc_var += pow(auc_mean - value, 2)
		i = (i+1) % 3
acc_dev = pow(acc_var / model_num, 0.5)
auc_dev = pow(auc_var / model_num, 0.5)

print("acc:", acc_mean, acc_dev)
print("auc:", auc_mean, auc_dev)
