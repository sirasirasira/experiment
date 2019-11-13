for x in 6 8
do
	for d in 1 3 5
	do
		for s in 0.1 0.4 0.7 1
		do
			cat maxpat${x}_depth${d}_shrinkage${s}/gtb_correct >> gtb_correct
		done
	done
done
