data=$1
maxpat=$2
depth=$3
shrinkage=$4

mkdir ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}
cd ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}

#gtb correct
> ./gtb_correct
for x in ${maxpat}
do
	for m in 1
	do
		for d in ${depth}
		do
			for s in ${shrinkage}
			do
				echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, shrinkage: ${s}" >> ./gtb_correct
				> ./gtb_acc
				> ./gtb_auc
				for idx in 0 1 2 3 4 5 6 7 8 9
				do
					../../../../../bin/gtb_correct -x ${x} -m ${m} -d ${d} -s ${s} -t 500 ../../../../../data/${data}_buckets/train${idx}.gsp ../../../../../data/${data}_buckets/test${idx}.gsp > ./model${idx}
					grep -a testacc ./model${idx} | cut -d " " -f 4 >> ./gtb_acc
					grep -a testauc ./model${idx} | cut -d " " -f 4 >> ./gtb_auc
				done
			done
		done
	done
done
