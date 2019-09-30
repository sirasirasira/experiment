import sys
import numpy as np

args = sys.argv
acc_file = args[1]
auc_file = args[2]
tree_num = int(args[3])

with open(acc_file, "r") as f:
	acc = np.array([float(v) for v in f])

with open(auc_file, "r") as f:
	auc = np.array([float(v) for v in f])

acc = acc.reshape(tree_num, -1)
auc = auc.reshape(tree_num, -1)
acc_mean = np.mean(acc, axis=0)
max_acc_mean = np.max(acc_mean)
max_acc_index = np.argmax(acc_mean)
max_acc_dev = np.std(auc[:, max_acc_index])
target_auc_mean = np.mean(auc[:, max_acc_index])
target_auc_dev = np.std(auc[:, max_acc_index])

print("tree_num:", max_acc_index)
print("acc:", max_acc_mean, max_acc_dev)
print("auc:", target_auc_mean, target_auc_dev)
