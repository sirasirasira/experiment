data=aids_ca_vs_cm

mkdir ./result/${data}
mkdir ./result/${data}/grid_search
mkdir ./result/${data}/grid_search/gtb

x=6
d=3
for s in 0.7 1.0
do
	./gtb_detail.sh ${data} ${x} ${d} ${s} &
done

x=6
d=5
for s in 0.4 0.7 1.0
do
	./gtb_detail.sh ${data} ${x} ${d} ${s} &
done

x=8
d=1
for s in 0.4 0.7 1.0
do
	./gtb_detail.sh ${data} ${x} ${d} ${s} &
done

x=8
d=3
s=0.1
mkdir ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}
> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, shrinkage: ${s}" >> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
for idx in 2 4 6 8
do
	./gtb_detail2.sh ${data} ${x} ${d} ${s} ${idx}&
done

for s in 0.4 0.7 1.0
do
	mkdir ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}
	> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
	echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, shrinkage: ${s}" >> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
	for idx in 0 2 4 6 8
	do
		./gtb_detail2.sh ${data} ${x} ${d} ${s} ${idx}&
	done
done

x=8
d=5
s=0.1
mkdir ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}
> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, shrinkage: ${s}" >> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
for idx in 2 3 4 5 6 7 8 9
do
	./gtb_detail3.sh ${data} ${x} ${d} ${s} ${idx}&
done

for s in 0.4 0.7 1.0
do
	mkdir ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}
	> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
	echo "# maxpat: ${x}, minsup: ${m}, depth: ${d}, shrinkage: ${s}" >> ./result/${data}/grid_search/gtb/maxpat${maxpat}_depth${depth}_shrinkage${shrinkage}/gtb_correct
	for idx in 0 1 2 3 4 5 6 7 8 9
	do
		./gtb_detail3.sh ${data} ${x} ${d} ${s} ${idx}&
	done
done
