data=$1
maxpat=$2
depth=$3
shrinkage=$4
bucket=$5

mkdir ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/bucket${bucket}
cd ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/bucket${bucket}

#gtb correct
for x in ${maxpat}
do
	for m in 1
	do
		for d in ${depth}
		do
			for s in ${shrinkage}
			do
				> ./gtb_acc
				> ./gtb_auc
				for idx in ${bucket}
				do
					../../../../../../bin/gtb_correct -x ${x} -m ${m} -d ${d} -s ${s} -t 500 ../../../../../../data/${data}_buckets/train${idx}.gsp ../../../../../../data/${data}_buckets/test${idx}.gsp > ./model${idx}
					grep -a testacc ./model${idx} | cut -d " " -f 4 >> ./gtb_acc
					grep -a testauc ./model${idx} | cut -d " " -f 4 >> ./gtb_auc
				done
			done
		done
	done
done
