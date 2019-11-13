import sys

args = sys.argv
filename = args[1]

feature = 0
trainacc = 0
trainauc = 0
trainloss_mean = 0
testacc = 0
testauc = 0
cache_size = 0
gain_count = 0
bound_count = 0
time = 0

with open(filename, "r") as f:
	i = 0
	for line in f:
		if i == 0:
			feature = float(line.split()[3])
		elif i == 1:
			trainacc = float(line.split()[3])
		elif i == 2:
			trainacc = float(line.split()[3])
		elif i == 3:
			trainloss_mean = float(line.split()[3])
		elif i == 4:
			testacc = float(line.split()[3])
		elif i == 5:
			testauc = float(line.split()[3])
		elif i == 6:
			testloss_mean = float(line.split()[3])
		elif i == 7:
			cache_size = float(line.split()[3])
		elif i == 8:
			gain_count = float(line.split()[3])
		elif i == 9:
			bound_count = float(line.split()[3])
		elif i == 10:
			time = float(line.split()[1])
		i = (i+1) % 11

print("time:", time)
print("trainacc:", trainacc)
print("trainauc:", trainauc)
print("trainloss_mean:", trainloss_mean)
print("testacc:", testacc)
print("testauc:", testauc)
print("testloss_mean:", testloss_mean)
print("features size:", feature)
print("cache size:", cache_size)
print("gain count:", gain_count)
print("bound count:", bound_count)
