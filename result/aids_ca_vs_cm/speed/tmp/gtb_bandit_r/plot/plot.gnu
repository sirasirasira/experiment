set terminal png

# acc
set output "image/acc.png"
set xlabel "#monte carlo simulation"
set xrange [0:600]
set ylabel "acc"
set yrange [0.75:0.90]
plot "acc.dat" using 1:2:3 with yerrorlines lw 2 title "proposed", 0.789474 with lines lw 2 title "naive"

# auc
set output "image/auc.png"
set xlabel "#monte carlo simulation"
set xrange [0:600]
set ylabel "auc"
set yrange [0.75:0.90]
plot "auc.dat" using 1:2:3 with yerrorlines lw 2 title "proposed", 0.807553 with lines lw 2 title "naive"

# time
set output "image/time.png"
set xlabel "#monte carlo simulation"
set xrange [0:600]
set ylabel "time"
set autoscale y
#set yrange [0.70:0.90]
plot "time.dat" using 1:2:3 with yerrorlines lw 2 title "proposed", 32497.584 with lines lw 2 title "naive"

# cache
set output "image/cache.png"
set xlabel "#monte carlo simulation"
set xrange [0:600]
set ylabel "cache"
#set yrange [0.70:0.90]
plot "cache.dat" using 1:2:3 with yerrorlines lw 2 title "proposed", 1628066.0 with lines lw 2 title "naive"

# gain
set output "image/gain.png"
set xlabel "#monte carlo simulation"
set xrange [0:600]
set ylabel "gain"
#set yrange [0.70:0.90]
plot "gain.dat" using 1:2:3 with yerrorlines lw 2 title "proposed", 267916787.0 with lines lw 2 title "naive"

# bound
set output "bound.png"
set xlabel "#monte carlo simulation"
set xrange [0:600]
set ylabel "bound"
#set yrange [0.70:0.90]
set output "image/bound.png"
plot "bound.dat" using 1:2:3 with yerrorlines lw 2 title "proposed", 267916787.0 with lines lw 2 title "naive"
