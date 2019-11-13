cd ../

if [ $# -ne 1 ]
then
	echo "please input dataset name"
	exit
fi

data=$1

if [ ! -e ./data/${data}_buckets ]
then
	echo "not exist the dataset"
	exit
fi

mkdir ./result/${data}
mkdir ./result/${data}/speed
mkdir ./result/${data}/speed/gboost
cd ./result/${data}/speed/gboost

TIMEFORMAT=%R

#gboost correct
> ./gboost_correct
for x in 10
do
	for m in 1
	do
		for n in 0.3
		do
			echo "# maxpat: ${x}, minsup: ${m}, nu: ${n}" >> ./gboost_correct
			(time ../../../../bin/lpboost_correct -x ${x} -m ${1} -n ${n} ../../../../data/${data}_buckets/train0.gsp > ./gboost_res) 2> ./time
			(time ../../../../bin/evaluator ./model ../../../../data/${data}_buckets/test0.gsp > ./evaluator_res) 2>> ./time
			echo "acc: `python ../../../../bin/speed/auc_eval.py temp.txt 0`" >> ./gboost_correct
			echo "auc: `python ../../../../bin/speed/auc_eval.py temp.txt 1`" >> ./gboost_correct
			python ../../../../bin/speed/time_reshape.py ./time >> ./gboost_correct
			grep "iterator" ./gboost_res | tail -n 1 >> ./gboost_correct
			grep "cache size" ./gboost_res | tail -n 1 >> ./gboost_correct
			grep "search nodes" ./gboost_res | tail -n 1 >> ./gboost_correct
		done
	done
done
rm ./model ./temp.txt ./gboost_res ./evaluator_res ./time ./gmon.out
