if [ $# -ne 3 ]
then
	echo "please input dataset name"
	exit
fi

data=$1
maxpat=$2
depth=$3

if [ ! -e ./data/${data}_buckets ]
then
	echo "not exist the dataset"
	exit
fi

mkdir ./result/${data}
mkdir ./result/${data}/grid_search
mkdir ./result/${data}/grid_search/gtb_bandit
mkdir ./result/${data}/grid_search/gtb_bandit/maxpat${maxpat}_depth${depth}
cd ./result/${data}/grid_search/gtb_bandit/maxpat${maxpat}_depth${depth}

> ./dustbox

#gtb bandit
> ./gtb_bandit
for x in ${maxpat}
do
	for m in 1
	do
		for d in ${depth}
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
								../../../../../bin/gtb_bandit -x ${x} -m ${m} -d ${d} -s ${s} -i ${i} -c ${c} -t 500 ../../../../../data/${data}_buckets/train${idx}.gsp ../../../../../data/${data}_buckets/test${idx}.gsp > ./model
								grep -a testacc ./model | cut -d " " -f 4 >> ./gtb_acc
								grep -a testauc ./model | cut -d " " -f 4 >> ./gtb_auc
							done
							python ../../../../../bin/grid_search/gtb_mean.py ./gtb_acc ./gtb_auc >> ./gtb_bandit
					done
				done
			done
		done
	done
done
rm model gtb_acc gtb_auc dustbox
