#! /usr/bin/gnuplot
#
# purpose:
#	 generate data reduction graphs for the multi-threaded list project
#
# input: lab2_list.csv
#	1. test name
#	2. # threads
#	3. # iterations per thread
#	4. # lists
#	5. # operations performed (threads x iterations x (ins + lookup + delete))
#	6. run time (ns)
#	7. run time per operation (ns)
#
# output:
#	lab2_list-1.png ... cost per operation vs threads and iterations
#	lab2_list-2.png ... threads and iterations that run (un-protected) w/o failure
#	lab2_list-3.png ... threads and iterations that run (protected) w/o failure
#	lab2_list-4.png ... cost per operation vs number of threads
#
# Note:
#	Managing data is simplified by keeping all of the results in a single
#	file.  But this means that the individual graphing commands have to
#	grep to select only the data they want.
#
#	Early in your implementation, you will not have data for all of the
#	tests, and the later sections may generate errors for missing data.
#

# general plot parameters
set terminal png
set datafile separator ","

#lab2b_1.png
set title "List1: Throughput vs Number of Threads"
set xlabel "Number of Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "Throughput (number of operations/sec)"
set logscale y 10
set output 'lab2b_1.png'
plot \
     "< grep -e 'list-none-m,[0-9]*,1000,1' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title 'list w/mutex' with linespoints lc rgb 'blue', \
     "< grep -e 'list-none-s,[0-9]*,1000,1' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title 'list w/spin-lock' with linespoints lc rgb 'green'

#lab2b_2.png
set title "List2: Wait for Lock Time and Avg Time per Op vs Num Threads (for mutexes)"
set xlabel "Number of Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "Time (ns)"
set logscale y 10
set output 'lab2b_2.png'
plot \
     "< grep -e 'list-none-m,[0-9]*,1000,1' lab2b_list.csv" using ($2):($7) \
	title 'avg time per op' with linespoints lc rgb 'blue', \
     "< grep -e 'list-none-m,[0-9]*,1000,1' lab2b_list.csv" using ($2):($8) \
	title 'avg wait time for lock' with linespoints lc rgb 'green'

#lab2b_3.png
set title "List3: Number of Threads vs. Successful iterations"
set xlabel "Number of Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "succesful iterations"
set logscale y 10
set output 'lab2b_3.png'
plot \
     "< grep -e 'list-id-none,[0-9]*,[0-9]*,4,' lab2b_list.csv" using ($2):($3) \
	title 'no locks w/ yield' with points lc rgb 'blue', \
     "< grep -e 'list-id-m,[0-9]*,[0-9]*,4,' lab2b_list.csv" using ($2):($3) \
	title 'mutex w/ yield' with points lc rgb 'green', \
     "< grep -e 'list-id-s,[0-9]*,[0-9]*,4,' lab2b_list.csv" using ($2):($3) \
	title 'spin w/ yield' with points lc rgb 'red'

#lab2b_4.png
set title "List4: Throughput vs Number of Threads"
set xlabel "Number of Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "Throughput (number of operations/sec)"
set logscale y 10
set output 'lab2b_4.png'
plot \
     "< grep -e 'list-none-m,[0-9]*,1000,1,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '1 list w/mutex' with linespoints lc rgb 'blue', \
     "< grep -e 'list-none-m,[0-9]*,1000,4,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '4 lists w/mutex' with linespoints lc rgb 'green', \
     "< grep -e 'list-none-m,[0-9]*,1000,8,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '8 lists w/mutex' with linespoints lc rgb 'red', \
     "< grep -e 'list-none-m,[0-9]*,1000,16,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '16 lists w/mutex' with linespoints lc rgb 'purple'

#lab2b_5.png
set title "List5: Throughput vs Number of Threads"
set xlabel "Number of Threads"
set logscale x 2
set xrange [0.75:]
set ylabel "Throughput (number of operations/sec)"
set logscale y 10
set output 'lab2b_5.png'
plot \
     "< grep -e 'list-none-s,[0-9]*,1000,1,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '1 list w/spin-lock' with linespoints lc rgb 'blue', \
     "< grep -e 'list-none-s,[0-9]*,1000,4,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '4 lists w/spin-lock' with linespoints lc rgb 'green', \
     "< grep -e 'list-none-s,[0-9]*,1000,8,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '8 lists w/spin-lock' with linespoints lc rgb 'red', \
     "< grep -e 'list-none-s,[0-9]*,1000,16,' lab2b_list.csv" using ($2):(1000000000/($7)) \
	title '16 lists w/spin-lock' with linespoints lc rgb 'purple'