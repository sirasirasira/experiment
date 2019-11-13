mkdir dat
> time.txt
> trainacc.txt
> trainauc.txt
> trainloss_mean.txt
> testacc.txt
> testauc.txt
> testloss_mean.txt
> feature.txt
> cache.txt
> gain.txt
> bound.txt
> dat/index
#for i in 10 40 70 100 200 300 400 500
for i in 10 100 200 300 400 500
do
	echo ${i} >> dat/index
	grep time ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> time.txt
	grep trainacc ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> trainacc.txt
	grep trainauc ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> trainauc.txt
	grep trainloss_mean ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> trainloss_mean.txt
	grep testacc ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> testacc.txt
	grep testauc ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> testauc.txt
	grep testloss_mean ../iteration_${i}/gtb_bandit_r | cut -d " " -f 2,3 >> testloss_mean.txt
	grep feature ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> feature.txt
	grep cache ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> cache.txt
	grep gain ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> gain.txt
	grep bound ../iteration_${i}/gtb_bandit_r | cut -d " " -f 3,4 >> bound.txt
done

paste dat/index time.txt > dat/time.dat
paste dat/index trainacc.txt > dat/trainacc.dat
paste dat/index trainauc.txt > dat/trainauc.dat
paste dat/index trainloss_mean.txt > dat/trainloss_mean.dat
paste dat/index testacc.txt > dat/testacc.dat
paste dat/index testauc.txt > dat/testauc.dat
paste dat/index testloss_mean.txt > dat/testloss_mean.dat
paste dat/index feature.txt > dat/feature.dat
paste dat/index cache.txt > dat/cache.dat
paste dat/index gain.txt > dat/gain.dat
paste dat/index bound.txt > dat/bound.dat

rm time.txt
rm trainacc.txt
rm trainauc.txt
rm trainloss_mean.txt
rm testacc.txt
rm testauc.txt
rm testloss_mean.txt
rm feature.txt
rm cache.txt
rm gain.txt
rm bound.txt
