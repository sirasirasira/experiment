cd ../

if [ $# -ne 2 ]
then
	echo "please input dataset name"
	exit
fi

data=$1
iteration=$2

if [ ! -e ./data/${data}_buckets ]
then
	echo "not exist the dataset"
	exit
fi

mkdir ./result/${data}
mkdir ./result/${data}/speed
mkdir ./result/${data}/speed/gtb_bandit_r
mkdir ./result/${data}/speed/gtb_bandit_r/iteration_${iteration}
mkdir ./result/${data}/speed/gtb_bandit_r/iteration_${iteration}/model_dir
cd ./result/${data}/speed/gtb_bandit_r/iteration_${iteration}

TIMEFORMAT=%R

#gtb correct
> ./gtb_bandit_r
for x in 10
do
	for m in 1
	do
		for d in 3
		do
			for t in 100
			do
				for i in ${iteration}
				do
					for c in 1
					do
						echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, tree_num: ${t}, iteration: ${i}, C: ${c}" >> ./gtb_bandit_r
						> ./rdm_res
						for rdm in 0 1 2 3 4 5 6 7 8 9
						do
							echo "#rdm ${rdm}" >> ./rdm_res
							(time ../../../../../bin/gtb_bandit_r -x ${x} -m ${m} -d ${d} -t ${t} -i ${i} -c ${c} ../../../../../data/${data}_buckets/train0.gsp ../../../../../data/${data}_buckets/test0.gsp > ./model) 2> ./time
							tail -n 11 ./model | head -n 10 > ./gtb_res
							python ../../../../../bin/speed/time_reshape.py ./time >> ./gtb_res
							python ../../../../../bin/speed/gtb_res_reshape.py ./gtb_res >> ./rdm_res
							cat ./model > ./model_dir/model_x${x}_m${m}_d${d}_t${t}_i${i}_c${c}_${rdm}
						done
						python ../../../../../bin/speed/gtb_bandit_r_mean.py ./rdm_res >> ./gtb_bandit_r
					done
				done
			done
		done
	done
done
rm ./model ./gtb_res ./rdm_res ./time ./gmon.out
