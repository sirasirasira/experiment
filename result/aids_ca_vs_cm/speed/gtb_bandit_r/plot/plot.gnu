set terminal postscript eps color enhanced
set size 0.7, 0.6
set key top outside

# trainacc
set output "image/trainacc.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "training ACC"
set yrange [0.75:0.90]
plot "dat/trainacc.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 0.999931 with lines lw 4 title "naive GTB"

# trainauc
set output "image/trainauc.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "training AUC"
set yrange [0.75:0.90]
plot "dat/trainauc.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 0 with lines lw 4 title "naive GTB"

# trainloss_mean
set output "image/trainloss_mean.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "average training loss"
set autoscale y
#set yrange [0.03:0.24]
plot "dat/trainloss_mean.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 0.0487844 with lines lw 4 title "naive GTB"

# testacc
set output "image/testacc.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "test ACC"
set yrange [0.72:0.88]
plot "dat/testacc.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 0.789474 with lines lw 4 title "naive GTB"

# testauc
set output "image/testauc.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "test AUC"
set yrange [0.75:0.90]
plot "dat/testauc.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 0.807553 with lines lw 4 title "naive GTB"

# testloss_mean
set output "image/testloss_mean.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "average test loss"
set autoscale y
#set yrange [0.75:0.90]
plot "dat/testloss_mean.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 0.607319 with lines lw 4 title "naive GTB"

set logscale y

# time
set output "image/time.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "time[s]"
set yrange [10:200000]
plot "dat/time.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 32535.834 with lines lw 4 title "naive GTB"

# cache
set output "image/cache.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "searched space size"
set autoscale y
#set yrange [0.70:0.90]
plot "dat/cache.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 1628066.0 with lines lw 4 title "naive GTB"

# gain
set output "image/gain.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "gain"
set autoscale y
#set yrange [0.70:0.90]
plot "dat/gain.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 267916787.0 with lines lw 4 title "naive GTB"

# bound
set output "image/bound.eps"
set xlabel "#monte carlo simulations"
set xrange [0:600]
set ylabel "bound"
set autoscale y
#set yrange [0.70:0.90]
set output "image/bound.eps"
plot "dat/bound.dat" using 1:2:3 with yerrorlines lw 4 title "proposed", 267916787.0 with lines lw 4 title "naive GTB"
