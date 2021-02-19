#NAME: Forrest Burton
#EMAIL: burton.forrest10@gmail.com
#ID: 005324612

default:
	gcc -Wall -Wextra -pthread -g -o lab2_list lab2_list.c SortedList.c

tests: default
	rm -f lab2_list.csv   
	
	#Graph 1 and 2
	./lab2_list --threads=1 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list --threads=2 --iterations=1000 --sync=m >>lab2b_list.csv 
	./lab2_list --threads=4 --iterations=1000 --sync=m >>lab2b_list.csv 
	./lab2_list --threads=8 --iterations=1000 --sync=m >>lab2b_list.csv 
	./lab2_list --threads=12 --iterations=1000 --sync=m >>lab2b_list.csv 
	./lab2_list --threads=16 --iterations=1000 --sync=m >>lab2b_list.csv 
	./lab2_list --threads=24 --iterations=1000 --sync=m >>lab2b_list.csv  
	
	./lab2_list --threads=1 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list --threads=2 --iterations=1000 --sync=s >>lab2b_list.csv 
	./lab2_list --threads=4 --iterations=1000 --sync=s >>lab2b_list.csv 
	./lab2_list --threads=8 --iterations=1000 --sync=s >>lab2b_list.csv 
	./lab2_list --threads=12 --iterations=1000 --sync=s >>lab2b_list.csv 
	./lab2_list --threads=16 --iterations=1000 --sync=s >>lab2b_list.csv 
	./lab2_list --threads=24 --iterations=1000 --sync=s >>lab2b_list.csv  

	#Graph 3
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=1 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=2 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=4 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=8 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=1 --iterations=16 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=1 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=2 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=4 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=8 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=4 --iterations=16 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=1 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=2 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=4 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=8 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=8 --iterations=16 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=1 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=2 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=4 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=8 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=12 --iterations=16 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=1 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=2 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=4 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=8 >>lab2b_list.csv
	-./lab2_list --yield=id --lists=4 --threads=16 --iterations=16 >>lab2b_list.csv

	./lab2_list --yield=id --lists=4 --threads=1 --iterations=10 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=1 --iterations=20 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=1 --iterations=40 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=1 --iterations=80 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=10 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=20 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=40 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=80 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=10 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=20 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=40 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=80 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=10 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=20 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=40 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=80 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=10 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=20 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=40 --sync=m >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=80 --sync=m >>lab2b_list.csv

	./lab2_list --yield=id --lists=4 --threads=1 --iterations=10 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=1 --iterations=20 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=1 --iterations=40 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=1 --iterations=80 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=10 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=20 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=40 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=4 --iterations=80 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=10 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=20 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=40 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=8 --iterations=80 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=10 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=20 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=40 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=12 --iterations=80 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=10 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=20 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=40 --sync=s >>lab2b_list.csv
	./lab2_list --yield=id --lists=4 --threads=16 --iterations=80 --sync=s >>lab2b_list.csv

	#Graph 4 and 5          
	./lab2_list  --lists=1 --threads=1 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=1 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=1 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=1 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=2 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=2 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=2 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=2 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=4 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=4 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=4 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=4 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=8 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=8 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=8 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=8 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=12 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=12 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=12 --iterations=1000 --sync=s >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=12 --iterations=1000 --sync=s >>lab2b_list.csv

	./lab2_list  --lists=1 --threads=1 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=1 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=1 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=1 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=2 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=2 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=2 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=2 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=4 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=4 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=4 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=4 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=8 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=8 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=8 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=8 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=1 --threads=12 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=4 --threads=12 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=8 --threads=12 --iterations=1000 --sync=m >>lab2b_list.csv
	./lab2_list  --lists=16 --threads=12 --iterations=1000 --sync=m >>lab2b_list.csv


profile: default
	-rm -f ./raw.gperf profile.out
	LD_PRELOAD=/usr/lib64/libprofiler.so CPUPROFILE=./raw.gperf ./lab2_list --threads=12 --iterations=1000 --sync=s
	pprof --text ./lab2_list ./raw.gperf > profile.out
	pprof --list=thread_tasks ./lab2_list ./raw.gperf >> profile.out 

graphs: tests
	gnuplot ./lab2_list.gp

dist: graphs
	tar -czvf lab2b-005324612.tar.gz SortedList.h SortedList.c lab2_list.c lab2_list.gp lab2b_list.csv lab2b_1.png lab2b_2.png lab2b_3.png lab2b_4.png lab2b_5.png README Makefile 

clean:
	rm -f lab2_list *tar.gz