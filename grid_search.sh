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
cd ./result/${data}/grid_search

> ./dustbox

#gboost correct
> ./gboost_correct
for x in 4 6 8
do
	for m in 1
	do
		for n in 0.01 0.1 0.2 0.3 0.4 0.5 0.6
		do
			echo "# maxpat: ${x}, minsup: ${m}, nu: ${n}" >> ./gboost_correct
			> ./10fold
			for idx in 0 1 2 3 4 5 6 7 8 9
			do
				echo "#model ${idx}" >> ./10fold
				../../../bin/lpboost_correct -x ${x} -m ${m} -n ${n} ../../../data/${data}_buckets/train${idx}.gsp > ./dustbox
				../../../bin/evaluator ./model ../../../data/${data}_buckets/test${idx}.gsp > ./dustbox
				python ../../../bin/grid_search/auc_eval.py ./temp.txt 0 >> ./10fold
				python ../../../bin/grid_search/auc_eval.py ./temp.txt 1 >> ./10fold
			done
			python ../../../bin/grid_search/gboost_mean.py ./10fold >> ./gboost_correct
		done
	done
done
rm model temp.txt ./10fold

#gtb correct
> ./gtb_correct
for x in 4 6 8
do
	for m in 1
	do
		for d in 1 3 5
		do
			for s in 0.1 0.4 0.7 1.0
			do
				echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, shrinkage: ${s}" >> ./gtb_correct
				> ./gtb_acc
				> ./gtb_auc
				for idx in 0 1 2 3 4 5 6 7 8 9
				do
					../../../bin/gtb_correct -x ${x} -m ${m} -d ${d} -s ${s} -t 500 ../../../data/${data}_buckets/train${idx}.gsp ../../../data/${data}_buckets/test${idx}.gsp > ./model
					grep -a testacc ./model | cut -d " " -f 4 >> ./gtb_acc
					grep -a testauc ./model | cut -d " " -f 4 >> ./gtb_auc
				done
				python ../../../bin/grid_search/gtb_mean.py ./gtb_acc ./gtb_auc >> ./gtb_correct
			done
		done
	done
done
rm ./model ./gtb_acc ./gtb_auc

#gtb bandit
> ./gtb_bandit
for x in 4 6 8
do
	for m in 1
	do
		for d in 1 3 5
		do
			for s in 0.1 0.4 0.7 1.0
			do
				for i in 100 300 500
				do
					for c in 1 10 100
					do
							echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, shrinkage: ${s}, iteration: ${i}, c: ${c}" >> ./gtb_bandit
							> ./gtb_acc
							> ./gtb_auc
							for idx in 0 1 2 3 4 5 6 7 8 9
							do
								../../../bin/gtb_bandit -x ${x} -m ${m} -d ${d} -s ${s} -i ${i} -c ${c} -t 500 ../../../data/${data}_buckets/train${idx}.gsp ../../../data/${data}_buckets/test${idx}.gsp > ./model
								grep -a testacc ./model | cut -d " " -f 4 >> ./gtb_acc
								grep -a testauc ./model | cut -d " " -f 4 >> ./gtb_auc
							done
							python ../../../bin/grid_search/gtb_mean.py ./gtb_acc ./gtb_auc >> ./gtb_bandit
					done
				done
			done
		done
	done
done
rm ./model ./gtb_acc ./gtb_auc
rm ./dustbox ./gmon.out
