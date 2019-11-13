if [ $# -ne 1 ]
then
	echo "please input dataset name"
	exit
fi

data=$1

./gboost.sh ${data} &
for x in 4 6 8
do
	for d in 1 3 5
	do
		./gtb.sh ${data} ${x} ${d} &
		./gtb_bandit.sh ${data} ${x} ${d} &
	done
done
