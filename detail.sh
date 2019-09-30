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
> ./result/${data}/tmp1
> ./result/${data}/tmp2
> ./result/${data}/dustbox
TIMEFORMAT=%R

<< comment
#gboost correct
> ./result/${data}/gboost_correct
for idx in 0 1 2 3 4 5 6 7 8 9
do
	echo "#model ${idx}" >> ./result/${data}/tmp1
	(time ./bin/lpboost_correct -m 1 -x 8 -n 0.5 ./data/${data}_buckets/train${idx}.gsp > ./result/${data}/tmp2) 2>> ./result/${data}/tmp1
	(time ./bin/evaluator ./model ./data/${data}_buckets/test${idx}.gsp > ./result/${data}/dustbox) 2>> ./result/${data}/tmp1
	grep "iterator" ./result/${data}/tmp2 | tail -n 1 >> ./result/${data}/tmp1
	python ./bin/auc_eval.py temp.txt 0 >> ./result/${data}/tmp1
	python ./bin/auc_eval.py temp.txt 1 >> ./result/${data}/tmp1
	grep "cache size" ./result/${data}/tmp2 | tail -n 1 >> ./result/${data}/tmp1
	grep "search nodes" ./result/${data}/tmp2 | tail -n 1 >> ./result/${data}/tmp1
done
python ./bin/gboost_mean.py ./result/${data}/tmp1 >> ./result/${data}/gboost_correct
rm model temp.txt

#gtb correct
> ./result/${data}/gtb_correct
> ./result/${data}/tmp1
for idx in 0 1 2 3 4 5 6 7 8 9
do
	echo "#model ${idx}" >> ./result/${data}/tmp1
	(time ./bin/gtb_correct -m 1 -x 8 -d 3 -t 100 ./data/${data}_buckets/train${idx}.gsp ./data/${data}_buckets/test${idx}.gsp > ./result/${data}/tmp2) 2>> ./result/${data}/tmp1
	tail -n 11 ./result/${data}/tmp2 | head -n 10 >> ./result/${data}/tmp1
done
python ./bin/gtb_mean.py ./result/${data}/tmp1 >> ./result/${data}/gtb_correct
comment

#gtb bandit
for i in 100 300 500
do
	> ./result/${data}/gtb_bandit
	for rdm in 0 1 2 3 4 5 6 7 8 9
	do
		> ./result/${data}/tmp1
		echo "#rdm ${rdm}" >> ./result/${data}/gtb_bandit
		for idx in 0 1 2 3 4 5 6 7 8 9
		do
			echo "#model ${idx}" >> ./result/${data}/tmp1
			(time ./bin/gtb_bandit -m 1 -x 8 -d 3 -t 100 -i ${i} ./data/${data}_buckets/train${idx}.gsp ./data/${data}_buckets/test${idx}.gsp > ./result/${data}/tmp2) 2>> ./result/${data}/tmp1
			tail -n 11 ./result/${data}/tmp2 | head -n 10 >> ./result/${data}/tmp1
		done
		python ./bin/gtb_mean.py ./result/${data}/tmp1 >> ./result/${data}/gtb_bandit
	done
	python ./bin/gtb_bandit_mean.py ./result/${data}/gtb_bandit > ./result/${data}/gtb_bandit_${i}
done

rm ./result/${data}/dustbox ./result/${data}/gtb_bandit ./result/${data}/tmp*
