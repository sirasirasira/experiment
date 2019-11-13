mkdir feature
> ./feature/feature_rate_summary.dat
> ./feature/tmp
> ./feature/index
> ./feature/column
for i in 1 2 3 4 5 6 7 8 9 10
do
	echo "${i}" >> feature/index
done
echo "10	100	200	300	400	500	naive" >> feature/column

paste -d "" feature/index feature/feature_rate_summary.dat > feature/tmp
cp feature/tmp feature/feature_rate_summary.dat
#for i in 10 40 70 100 200 300 400 500
for i in 10 100 200 300 400 500
do
	paste feature/feature_rate_summary.dat ../iteration_${i}/feature/feature_rate.dat > feature/tmp
	cp feature/tmp feature/feature_rate_summary.dat
done
paste feature/feature_rate_summary.dat ../../gtb/feature_rate.dat > feature/tmp
cp feature/tmp feature/feature_rate_summary.dat

cat feature/feature_rate_summary.dat >> feature/column 
cp feature/column feature/feature_rate_summary.dat

rm feature/index
rm feature/column
rm feature/tmp
