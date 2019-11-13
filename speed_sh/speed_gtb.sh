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
mkdir ./result/${data}/speed/gtb
cd ./result/${data}/speed/gtb

TIMEFORMAT=%R

#gtb correct
> ./gtb_correct
for x in 10
do
	for m in 1
	do
		for d in 3
		do
			for t in 100
			do
				echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, tree_num: ${t}" >> ./gtb_correct
				(time ../../../../bin/gtb_correct -x ${x} -m ${m} -d ${d} -t ${t} ../../../../data/${data}_buckets/train0.gsp ../../../../data/${data}_buckets/test0.gsp > ./model) 2> ./time
				tail -n 11 ./model | head -n 10 > ./gtb_res
				python ../../../../bin/speed/time_reshape.py ./time >> ./gtb_res
				python ../../../../bin/speed/gtb_res_reshape.py ./gtb_res >> ./gtb_correct
				cat ./model > ./model_x${x}_m${m}_d${d}_t${t}
			done
		done
	done
done
rm ./model ./gtb_res ./time ./gmon.out
