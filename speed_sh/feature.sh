if [ $# -ne 1 ]
then
	echo "please input iteration num"
	exit
fi

itr=$1

cd iteration_${itr}
mkdir feature

for i in 0 1 2 3 4 5 6 7 8 9
do
	grep "REPORT 100 FI" model_dir/model_x10_m1_d3_t100_i${itr}_c1_${i} | cut -d " " -f 4- | rev | cut -d " " -f 3- | rev > feature/feature_${i}
done
