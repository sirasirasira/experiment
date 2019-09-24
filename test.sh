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
> ./result/${data}/gtb_correct
> ./result/${data}/gtb_bandit

#gboost correct
#for idx in 0 1 2 3 4 5 6 7 8 9
for idx in 0 1
do
	./bin/lpboost_correct -m 1 -x 10 -n 0.5 ./data/${data}_buckets/train${idx}.gsp
	./bin/evaluator ./model ./data/${data}_buckets/test${idx}.gsp
done

#gtb correct
for idx in 0 1 2 3 4 5 6 7 8 9
do
	./bin/gtb_correct -m 1 -x 2 -d 3 -t 10 ./data/${data}_buckets/train${idx}.gsp ./data/${data}_buckets/test${idx}.gsp >> ./result/${data}/tmp1
	echo "#${idx} model" >> ./result/${data}/tmp2
	tail -n 11 ./result/${data}/tmp2 | head -n 10 >> ./result/${data}/tmp2
done
python ./bin/gtb_mean.py ./result/${data}/tmp2 >> ./result/${data}/gtb_correct

#gtb bandit
for idx in 0 1 2 3 4 5 6 7 8 9
do
	./bin/gtb_bandit -m 1 -x 2 -d 3 -t 10 -i 50 ./data/${data}_buckets/train${idx}.gsp ./data/${data}_buckets/test${idx}.gsp >> ./result/${data}/tmp1
	echo "#${idx} model" >> ./result/${data}/tmp2
	tail -n 11 ./result/${data}/tmp2 | head -n 10 >> ./result/${data}/tmp2
done
python ./bin/gtb_mean.py ./result/${data}/tmp2 >> ./result/${data}/gtb_bandit
