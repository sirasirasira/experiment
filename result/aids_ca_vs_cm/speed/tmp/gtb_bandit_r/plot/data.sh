> acc.txt
> time.txt
> feature.txt
> cache.txt
> gain.txt
> bound.txt
for i in 100 200 300 400 500
do
	grep acc ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> acc.txt
	grep auc ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> auc.txt
	grep time ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> time.txt
	grep feature ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> feature.txt
	grep cache ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> cache.txt
	grep gain ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> gain.txt
	grep bound ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> bound.txt
done

paste index.dat acc.txt > acc.dat
paste index.dat auc.txt > auc.dat
paste index.dat time.txt > time.dat
paste index.dat feature.txt > feature.dat
paste index.dat cache.txt > cache.dat
paste index.dat gain.txt > gain.dat
paste index.dat bound.txt > bound.dat

rm acc.txt
rm time.txt
rm feature.txt
rm cache.txt
rm gain.txt
rm bound.txt
