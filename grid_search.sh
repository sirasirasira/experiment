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
mkdir ./result/${data}/grid_search
> ./result/${data}/grid_search/dustbox

#gboost correct
> ./result/${data}/grid_search/gboost_correct
for x in 4 6 8 10
do
	for n in 0.01 0.1 0.2 0.3 0.4 0.5 0.6
	do
		echo "# maxpat: ${x}, nu: ${n}" >> ./result/${data}/grid_search/gboost_correct
		> ./result/${data}/grid_search/10fold
		for idx in 0 1 2 3 4 5 6 7 8 9
		do
			echo "#model ${idx}" >> ./result/${data}/grid_search/10fold
			./bin/lpboost_correct -x ${x} -n ${n} ./data/${data}_buckets/train${idx}.gsp > ./result/${data}/grid_search/dustbox
			./bin/evaluator ./model ./data/${data}_buckets/test${idx}.gsp > ./result/${data}/grid_search/dustbox
			python ./bin/grid_search/auc_eval.py temp.txt 0 >> ./result/${data}/grid_search/10fold
			python ./bin/grid_search/auc_eval.py temp.txt 1 >> ./result/${data}/grid_search/10fold
		done
		python ./bin/grid_search/gboost_mean.py ./result/${data}/grid_search/10fold >> ./result/${data}/grid_search/gboost_correct
	done
done
rm model temp.txt ./result/${data}/grid_search/10fold

#gtb correct
> ./result/${data}/grid_search/gtb_correct
for x in 4 6 8 10
do
	for d in 1 3 5
	do
		for s in 0.1 0.4 0.7 1.0
		do
			echo "# maxpat: ${x}, depth: ${d}, shrinkage: ${s}" >> ./result/${data}/grid_search/gtb_correct
			> ./result/${data}/grid_search/gtb_acc
			> ./result/${data}/grid_search/gtb_auc
			for idx in 0 1 2 3 4 5 6 7 8 9
			do
				./bin/gtb_correct -x ${x} -d ${d} -s ${s} -t 500 ./data/${data}_buckets/train${idx}.gsp ./data/${data}_buckets/test${idx}.gsp > ./result/${data}/grid_search/model
				grep testacc ./result/${data}/grid_search/model | cut -d " " -f 4 >> ./result/${data}/grid_search/gtb_acc
				grep testauc ./result/${data}/grid_search/model | cut -d " " -f 4 >> ./result/${data}/grid_search/gtb_auc
			done
			python ./bin/grid_search/gtb_mean.py ./result/${data}/grid_search/gtb_acc ./result/${data}/grid_search/gtb_auc 500 >> ./result/${data}/grid_search/gtb_correct
		done
	done
done
rm ./result/${data}/grid_search/model ./result/${data}/grid_search/gtb_acc ./result/${data}/grid_search/gtb_auc

#gtb bandit
> ./result/${data}/grid_search/gtb_bandit
for x in 4 6 8 10
do
	for d in 1 3 5
	do
		for s in 0.1 0.4 0.7 1.0
		do
			for i in 100 300 500 700 1000
			do
				for c in 1 10 100
				do
					echo "# maxpat: ${x}, depth: ${d}, shrinkage: ${s}, iteration: ${i}, c: ${c}" >> ./result/${data}/grid_search/gtb_bandit
					> ./result/${data}/grid_search/gtb_acc
					> ./result/${data}/grid_search/gtb_auc
					for idx in 0 1 2 3 4 5 6 7 8 9
					do
						./bin/gtb_bandit -x ${x} -d ${d} -s ${s} -i ${i} -c ${c} -t 10 ./data/${data}_buckets/train${idx}.gsp ./data/${data}_buckets/test${idx}.gsp > ./result/${data}/grid_search/model
						grep testacc ./result/${data}/grid_search/model | cut -d " " -f 4 >> ./result/${data}/grid_search/gtb_acc
						grep testauc ./result/${data}/grid_search/model | cut -d " " -f 4 >> ./result/${data}/grid_search/gtb_auc
					done
					python ./bin/grid_search/gtb_mean.py ./result/${data}/grid_search/gtb_acc ./result/${data}/grid_search/gtb_auc 10 >> ./result/${data}/grid_search/gtb_bandit
				done
			done
		done
	done
done
rm ./result/${data}/grid_search/model ./result/${data}/grid_search/gtb_acc ./result/${data}/grid_search/gtb_auc
rm ./result/${data}/grid_search/dustbox gmon.out
