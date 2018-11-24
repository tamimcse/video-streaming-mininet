#!/bin/sh

set print "-"
set terminal png
set autoscale x
set autoscale y
set size ratio .5
#Set legend
set key inside right top
set datafile missing "-nan"
set style data line
#set style data linespoints

backloginigo='backlog0-inigo.data'
backlogim='backlog0-im.data'
backlogcdg='backlog0-cdg.data'
backlogxcp='backlog0-xcp.data'

tcp1='Inigo'
tcp2='NC-TCP'
tcp3='CDG'
xcp='XCP'

#Plot Fainess index
set autoscale y
set key inside right bottom
set output sprintf("fairness.png")
set xlabel "Time (Seconds)"
set ylabel "Fairness index"
plot "fairness-im.data" using 1:2 title tcp2, "fairness-inigo.data" using 1:2 title tcp1, "fairness-xcp.data" using 1:2 title xcp
#plot "fairness-im.data" using 1:2 title tcp2, "fairness-inigo.data" using 1:2 title tcp1


#Plot NC-TCP throughputs
set key inside right top
set output sprintf("flows-im.png",outPre)
set xlabel "Time (Seconds)"
set ylabel "Throughput (kbps)"
set autoscale y
plot "h1-im.data" using 1:($12 * 8 /1024) title "flow 1", "h3-im.data" using 1:($12 * 8 /1024) title "flow 2", "h5-im.data" using 1:($12 * 8 /1024) title "flow 3"

#Plot CDG throughputs
#set key inside right top
#set output sprintf("flows-cdg.png",outPre)
#set xlabel "Time (Seconds)"
#set ylabel "Throughput (kbps)"
#set autoscale y
#plot "h1-cdg.data" using 1:($12 * 8 /1024) title "flow 1", "h3-cdg.data" using 1:($12 * 8 /1024) title "flow 2", "h5-cdg.data" using 1:($12 * 8 /1024) title "flow 3"

#Plot Inigo throughputs
set key inside right top
set output sprintf("flows-inigo.png",outPre)
set xlabel "Time (Seconds)"
set ylabel "Throughput (kbps)"
set autoscale y
plot "h1-inigo.data" using 1:($12 * 8 /1024) title "flow 1", "h3-inigo.data" using 1:($12 * 8 /1024) title "flow 2", "h5-inigo.data" using 1:($12 * 8 /1024) title "flow 3"

#Plot queue backlog
#set yrange [0:70]
set output sprintf("backlog.png")
set xlabel "Time (Seconds)"
set ylabel "Queuing delay (msec)"
plot backlogim using 1:($2*8/(1024*1024)) title tcp2, backloginigo using 1:($2*8/(1024*1024)) title tcp1, backlogxcp using 1:($2*8/(1024*1024)) title xcp
#plot backlogim using 1:($2*8/(1024*1024)) title tcp2, backloginigo using 1:($2*8/(1024*1024)) title tcp1

set output sprintf("backlog1.png")
plot 'backlog1-im.data' using 1:($2*8/(1024*1024)) title tcp2, 'backlog1-inigo.data' using 1:($2*8/(1024*1024)) title tcp1, 'backlog1-xcp.data' using 1:($2*8/(1024*1024)) title xcp
#plot 'backlog1-im.data' using 1:($2*8/(1024*1024)) title tcp2, 'backlog1-inigo.data' using 1:($2*8/(1024*1024)) title tcp1

set output sprintf("backlog2.png")
plot 'backlog2-im.data' using 1:($2*8/(1024*1024)) title tcp2, 'backlog2-inigo.data' using 1:($2*8/(1024*1024)) title tcp1, 'backlog2-xcp.data' using 1:($2*8/(1024*1024)) title xcp
#plot 'backlog2-im.data' using 1:($2*8/(1024*1024)) title tcp2, 'backlog2-inigo.data' using 1:($2*8/(1024*1024)) title tcp1
