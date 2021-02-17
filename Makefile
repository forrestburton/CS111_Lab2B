#NAME: Forrest Burton
#EMAIL: burton.forrest10@gmail.com
#ID: 005324612

default:
	gcc -Wall -Wextra -pthread -g -o lab2_list lab2_list.c SortedList.c

tests: build
	rm -f lab2_list.csv   
	
	./lab2_list --threads=1 --iterations=1000 --sync=m >>lab2_list.csv
	./lab2_list --threads=2 --iterations=1000 --sync=m >>lab2_list.csv 
	./lab2_list --threads=4 --iterations=1000 --sync=m >>lab2_list.csv 
	./lab2_list --threads=8 --iterations=1000 --sync=m >>lab2_list.csv 
	./lab2_list --threads=12 --iterations=1000 --sync=m >>lab2_list.csv 
	./lab2_list --threads=16 --iterations=1000 --sync=m >>lab2_list.csv 
	./lab2_list --threads=24 --iterations=1000 --sync=m >>lab2_list.csv  
	
	./lab2_list --threads=1 --iterations=1000 --sync=s >>lab2_list.csv
	./lab2_list --threads=2 --iterations=1000 --sync=s >>lab2_list.csv 
	./lab2_list --threads=4 --iterations=1000 --sync=s >>lab2_list.csv 
	./lab2_list --threads=8 --iterations=1000 --sync=s >>lab2_list.csv 
	./lab2_list --threads=12 --iterations=1000 --sync=s >>lab2_list.csv 
	./lab2_list --threads=16 --iterations=1000 --sync=s >>lab2_list.csv 
	./lab2_list --threads=24 --iterations=1000 --sync=s >>lab2_list.csv  

profile: default
	-rm -f ./raw.gperf
	LD_PRELOAD = /usr/lib64/libprofiler.so
	CPUPROFILE= ./raw.gperf ./lab2_list --threads=12 --iterations=1000 --sync=s
	pprof --text ./lab2_list ./raw.gperf > profile.out
	pprof --list=thread_tasks ./lab2_list ./raw.gperf >> profile.out 

graphs: tests
	gnuplot ./lab2_list.gp

dist: graphs
	tar -czvf lab2a-005324612.tar.gz SortedList.h SortedList.c lab2_list.c lab2_list.gp lab2b_list.csv lab2b_1.png lab2b_2.png lab2b_3.png lab2b_4.png lab2b_5.png README Makefile 
	
clean:
	rm -f lab2_list *tar.gz
