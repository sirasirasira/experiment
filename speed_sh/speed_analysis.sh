if [ $# -ne 1 ]
then
	echo "please input dataset name"
	exit
fi

data=$1

#./speed_gboost.sh ${data}
./speed_gtb.sh ${data}
for i in 10 40 70 100 200 300 400 500
do
	./speed_gtb_bandit.sh ${data} ${i}
done
