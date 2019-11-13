for idx in 0 2 4 6 8
do
	cat bucket${idx}/gtb_acc >> gtb_acc
	cat bucket${idx}/gtb_auc >> gtb_auc
done

if [ `cat gtb_acc | wc -l` -ne 5000 ]
then
	echo "acc output error"
	exit
fi
if [ `cat gtb_auc | wc -l` -ne 5000 ]
then
	echo "auc output error"
	exit
fi

python ~/desktop/experiment/bin/grid_search/gtb_mean.py gtb_acc gtb_auc >> gtb_correct
cat gtb_correct
