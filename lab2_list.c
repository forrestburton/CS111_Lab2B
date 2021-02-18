//NAME: Forrest Burton
//EMAIL: burton.forrest10@gmail.com
//ID: 005324612

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <getopt.h>
#include <unistd.h>  
#include <pthread.h> 
#include <time.h>
#include <string.h>
#include "SortedList.h"
#include <signal.h>

pthread_t* threads = NULL;
int iterations = 1;
int thread_num = 1;
char yield_output[4];
int opt_y = 0;
int opt_sync = 0;
int opt_yield = 0;
pthread_mutex_t protect;
long spin_lock = 0;
int* num_thread = NULL;
int list_num = 1;
long long acquisition_time = 0;
long* mutex_wait_time = NULL;
SortedListElement_t *head = NULL;
SortedListElement_t *pool = NULL;

void catch_seg_fault() {
    fprintf(stderr, "Signal: Caught seg fault \n");
    exit(2);
}

unsigned long get_time(struct timespec* start_time, struct timespec* end_time) {
    long nsec = end_time->tv_nsec - start_time->tv_nsec;
    time_t sec = end_time->tv_sec - start_time->tv_sec;
    return (sec*1000000000 + nsec);
}

void free_memory(void) {
    if (threads != NULL) {
        free(threads);
    }
    for (int i = 0; i < iterations * thread_num; i++) {
        free((char*)(pool[i].key));
    }
    if (pool != NULL) {
        free(pool);
    }
    if (num_thread != NULL) {
        free(num_thread);
    }

    if (mutex_wait_time != NULL) {
        free(mutex_wait_time);
    }
}

void* thread_tasks(void *num_thread) {
    int n_thread = *((int*)num_thread);
    int base_index = n_thread;
    struct timespec start_time; //get start time
    struct timespec end_time; //get start time

    //insert
    for (int i = base_index; i < thread_num * iterations; i+=thread_num) {
        switch(opt_sync) {
            case 0:  //no sync option given
                SortedList_insert(head, &pool[i]);
                break;
            case 'm': //mutex
                if (clock_gettime(CLOCK_MONOTONIC, &start_time) == -1) {
                    fprintf(stderr, "Error getting start time: %s\n", strerror(errno));
                    exit(1);
                }
                if (pthread_mutex_lock(&protect) != 0) {
                    fprintf(stderr, "Error locking mutex\n");
                    exit(1);
                }
                if (clock_gettime(CLOCK_MONOTONIC, &end_time) == -1) {
                    fprintf(stderr, "Error getting end time: %s\n", strerror(errno));
                    exit(1);
                }

                acquisition_time[n_thread] += get_time(&start_time, &end_time);

                SortedList_insert(head, &pool[i]);
                if (pthread_mutex_unlock(&protect) != 0) {
                    fprintf(stderr, "Error unlocking mutex\n");
                    exit(1);
                }
                break;
            case 's':  //spinlock
                while (__sync_lock_test_and_set(&spin_lock, 1));
                SortedList_insert(head, &pool[i]);
                __sync_lock_release(&spin_lock);
                break;
            default: 
                fprintf(stderr, "Incorrect argument for sync, accepted are ['m', 's'] \n");
                exit(1);
                break;
        }   
    }

    //check length
    switch(opt_sync) {
        case 0:  //no sync option given
            if (SortedList_length(head) < 0) {
                fprintf(stderr, "Error: List is corrupted\n");
                exit(2);
            }
            break;
        case 'm': //mutex
            if (clock_gettime(CLOCK_MONOTONIC, &start_time) == -1) {
                fprintf(stderr, "Error getting start time: %s\n", strerror(errno));
                exit(1);
            }
            if (pthread_mutex_lock(&protect) != 0) {
                fprintf(stderr, "Error locking mutex\n");
                exit(1);
            }
            if (clock_gettime(CLOCK_MONOTONIC, &end_time) == -1) {
                fprintf(stderr, "Error getting end time: %s\n", strerror(errno));
                exit(1);
            }
            acquisition_time[n_thread] += get_time(&start_time, &end_time);

            if (SortedList_length(head) < 0) {
                fprintf(stderr, "Error: List is corrupted\n");
                exit(2);
            }
            if (pthread_mutex_unlock(&protect) != 0) {
                fprintf(stderr, "Error unlocking mutex\n");
                exit(1);
            }
            break;
        case 's':  //spinlock
            while (__sync_lock_test_and_set(&spin_lock, 1));
            if (SortedList_length(head) < 0) {
                fprintf(stderr, "Error: List is corrupted\n");
                exit(2);
            }
            __sync_lock_release(&spin_lock);
            break;
        default: 
            fprintf(stderr, "Incorrect argument for sync, accepted are ['m', 's'] \n");
            exit(1);
            break;
    }

    //lookup, remove
    SortedListElement_t* kill;
    int stop = base_index + iterations;
    for (int i = base_index; i < thread_num * iterations; i+=thread_num) {
        switch(opt_sync) {
            case 0:  //no sync option given
                kill = SortedList_lookup(head, pool[i].key);
                if (kill == NULL) {
                    fprintf(stderr, "Error looking up node for deletion, key is:%d, i is: %d, stop point is:%d, threads:%d, iterations:%d\n", *pool[i].key, i, stop, thread_num, iterations);
                    exit(2);
                }
                if (SortedList_delete(kill) == 1) {
                    fprintf(stderr, "Error deleting node, key is:%d, i is: %d, stop point is: %d, threads:%d, iterations:%d\n", *pool[i].key, i, stop, thread_num, iterations);
                    exit(2);
                }
                break;
            case 'm': //mutex
                if (clock_gettime(CLOCK_MONOTONIC, &start_time) == -1) {
                    fprintf(stderr, "Error getting start time: %s\n", strerror(errno));
                    exit(1);
                }
                if (pthread_mutex_lock(&protect) != 0) {
                    fprintf(stderr, "Error locking mutex\n");
                    exit(1);
                }
                if (clock_gettime(CLOCK_MONOTONIC, &end_time) == -1) {
                    fprintf(stderr, "Error getting end time: %s\n", strerror(errno));
                    exit(1);
                }

                acquisition_time[n_thread] += get_time(&start_time, &end_time);

                kill = SortedList_lookup(head, pool[i].key);
                if (kill == NULL) {
                    fprintf(stderr, "Error looking up node for deletion\n");
                    exit(2);
                }
                if (SortedList_delete(kill) == 1) {
                    fprintf(stderr, "Error deleting node\n");
                    exit(2);
                }
                if (pthread_mutex_unlock(&protect) != 0) {
                    fprintf(stderr, "Error unlocking mutex\n");
                    exit(1);
                }
                break;
            case 's':  //spinlock
                while (__sync_lock_test_and_set(&spin_lock, 1));
                kill = SortedList_lookup(head, pool[i].key);
                if (kill == NULL) {
                    fprintf(stderr, "Error looking up node for deletion\n");
                    exit(2);
                }
                if (SortedList_delete(kill) == 1) {
                    fprintf(stderr, "Error deleting node\n");
                    exit(2);
                }
                __sync_lock_release(&spin_lock);
                break;
            default: 
                fprintf(stderr, "Incorrect argument for sync, accepted are ['m', 's'] \n");
                exit(1);
                break;
        }
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    int c;

    while(1) {
        int option_index = 0;
        static struct option long_options[] = {
            {"threads", required_argument, 0, 't' },
            {"iterations", required_argument, 0, 'i' },
            {"yield", required_argument, 0, 'y' },
            {"sync", required_argument, 0, 's' },
            {0,     0,             0, 0 }};
        c = getopt_long(argc, argv, "t:i:y:s:", long_options, &option_index);
        if (c == -1) break;
        switch (c) {
            case 't':
                thread_num = atoi(optarg);
                if (thread_num < 1) {
                    fprintf(stderr, "Error: number of threads must be greater than 0");
                    exit(1);
                }
                break;
            case 'i':
                iterations = atoi(optarg);
                if (iterations < 1) {
                    fprintf(stderr, "Error: number of iterations must be greater than 0");
                    exit(1);
                }
                break;
            case 'y':
                opt_y = 1;
                int length = strlen(optarg);
                if (length >= 4) {
                    fprintf(stderr, "Incorrect yield argument, correct usage is --yield=[i,d,l,id,il,dl,idl]");
                    exit(1);
                }

                for (int i = 0; i < length; i++) {
                    char cur = optarg[i];
                    if (cur == 'i') {
                        strcat(yield_output, "i");
                        opt_yield = opt_yield | INSERT_YIELD;
                    }
                    else if (cur == 'd') {
                        strcat(yield_output, "d");
                        opt_yield = opt_yield | DELETE_YIELD;
                    }
                    else if (cur == 'l') {
                        strcat(yield_output, "l");
                        opt_yield = opt_yield | LOOKUP_YIELD;
                    }
                    else {
                        fprintf(stderr, "Incorrect yield argument, correct usage is --yield=[i,d,l,id,il,dl,idl]");
                        exit(1);
                    }
                }
                break;
            case 's':
                opt_sync = optarg[0];
                if (!(opt_sync != 'm' || opt_sync != 's')) {
                    fprintf(stderr, "Incorrect argument for sync, accepted are ['m', 's'] \n");
                    exit(1);
                }
                break;
            default:
                fprintf(stderr, "Incorrect usage, accepted options are: [--threads=th_num --iterations=it_num]\n");
                exit(1);
        }
    }
    atexit(free_memory); //must free allocated memory at exit

    head = malloc(sizeof(SortedListElement_t));
    head->key = NULL;
    head->prev = head;
    head->next = head;

    signal(SIGSEGV, catch_seg_fault);

    pool = malloc(thread_num * iterations * sizeof(SortedListElement_t));
    if (pool == NULL) {
        fprintf(stderr, "Error initializing memory for pool of elements: %s\n", strerror(errno));
        exit(1);
    }

    mutex_wait_time = malloc(thread_num * sizeof(long));
    if (mutex_wait_time == NULL) {
        fprintf(stderr, "Error initializing memory for mutex wait time array: %s\n", strerror(errno));
        exit(1);
    }

    srand(time(NULL));  
    for (int i = 0; i < thread_num * iterations; i++) { //initialize list elements with random keys
        int rand_length = (rand() % (12 - 2 + 1)) + 2;   //random key length of range 2-12
        char* rand_key = NULL;
        rand_key = (char*) malloc(rand_length*sizeof(char)); 
        if (rand_key == NULL) {
            fprintf(stderr, "Error initializing memory for key: %s\n", strerror(errno));
            exit(1);
        }
        rand_key[rand_length-1] = '\0';

        for (int i = 0; i < rand_length - 1; i++) {
            int rand_int = rand() % 26;  //random integer 0-25 for random english letter character
            rand_key[i] = rand_int;
        }
        pool[i].key = rand_key;
    }

    if (opt_sync == 'm') {
        if (pthread_mutex_init(&protect, NULL) != 0) {
            fprintf(stderr, "Error initializing mutex: %s\n", strerror(errno));
            exit(1);
        }
    }

    threads = malloc(sizeof(pthread_t) * thread_num); //allocate memory for array of threads
    if (threads == NULL) {
        fprintf(stderr, "Error, malloc (memory allocation) failed for threads: %s\n", strerror(errno));
        exit(1);
    }

    num_thread = (int*) malloc(thread_num * sizeof(int));  //thread number for starting index
    if (num_thread == NULL) {
        fprintf(stderr, "Error, malloc (memory allocation) failed for thread numbers: %s\n", strerror(errno));
        exit(1);
    }

    struct timespec start_time; //get start time
    if (clock_gettime(CLOCK_MONOTONIC, &start_time) == -1) {
        fprintf(stderr, "Error getting start time: %s\n", strerror(errno));
        exit(1);
    }

    for (int i = 0; i < thread_num; i++) { //create threads
        num_thread[i] = i;
        if (pthread_create(&threads[i], NULL, thread_tasks, &num_thread[i]) != 0) {
            fprintf(stderr, "Error, creation of a thread failed: %s\n", strerror(errno));
            exit(1);
        }
    }

    for (int i = 0; i < thread_num; i++) { //join threads
        if (pthread_join(threads[i], NULL) != 0) {
            fprintf(stderr, "Error, joining threads failed: %s\n", strerror(errno));
            exit(1);
        }
    } 

    struct timespec end_time;  //get end time
    if (clock_gettime(CLOCK_MONOTONIC, &end_time) == -1) {
        fprintf(stderr, "Error getting end time: %s\n", strerror(errno));
        exit(1);
    }

    if (SortedList_length(head) != 0) {
        fprintf(stderr, "\n");
        exit(1);
    }

    //get total time
    unsigned long total_time_nsec; 
    long nsec = end_time.tv_nsec - start_time.tv_nsec;
    time_t sec = end_time.tv_sec - start_time.tv_sec;
    total_time_nsec = sec*1000000000 + nsec;

    //get average time per operation
    long ops = thread_num * iterations * 3;
    long avg_time_per_op = total_time_nsec / ops;

    //print out stats - Name of test, thread#, itera#, operation#, runtime, avg t/oper, total
    char output[80] = "";
    strcat(output, "list-");
    //list-yieldopts-syncopts
    if (opt_y) {
        strcat(output, yield_output);
    }
    else {
        strcat(output, "none");
    }

    //get name of test
    switch (opt_sync) {
        case 0:  //no sync option given
            strcat(output, "-none");
            break;
        case 'm': //mutex
            strcat(output, "-m");
            break;
        case 's':  //spinlock
            strcat(output, "-s");
            break;
        default: 
            break;
    }

    if (mutex_wait_time != NULL) {
        for (int i = 0; i < thread_num; i++) {
            acquisition_time += mutex_wait_time[i];
        }
    }

    long long avg_wait_for_lock = acquisition_time / ops;

    fprintf(stdout, "%s,%d,%d,%d,%ld,%lu,%ld,%lld\n", output, thread_num, iterations, list_num, ops, total_time_nsec, avg_time_per_op, avg_wait_for_lock);
    exit(0);
}