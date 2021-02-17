//NAME: Forrest Burton
//EMAIL: burton.forrest10@gmail.com
//ID: 005324612

#include "SortedList.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sched.h>

/**
 * SortedList_insert ... insert an element into a sorted list
 *
 *	The specified element will be inserted in to
 *	the specified list, which will be kept sorted
 *	in ascending order based on associated keys
 *
 * @param SortedList_t *list ... header for the list
 * @param SortedListElement_t *element ... element to be added to the list
 */
void SortedList_insert(SortedList_t *list, SortedListElement_t *element) {
    if (list == NULL || element == NULL) {
        return;
    }
    
    if (list->key != NULL) { //head should have a value of null
        return;
    }

    SortedListElement_t *cur = list->next;
    SortedListElement_t *tmp = list;

    while (cur != list && strcmp(cur->key, element->key) > 0) { //circular list
        tmp = cur;
        cur = cur->next;
    }

    if (opt_yield && INSERT_YIELD) {
        sched_yield();
    }

    if (cur != NULL) { //inserting in middle
        element->next = cur;
        element->prev = tmp;
        tmp->next = element;
        cur->prev = element;
    }
    else {
        element->next = NULL;
        element->prev = tmp;
        tmp->next = element;
    }
}

/**
 * SortedList_delete ... remove an element from a sorted list
 *
 *	The specified element will be removed from whatever
 *	list it is currently in.
 *
 *	Before doing the deletion, we check to make sure that
 *	next->prev and prev->next both point to this node
 *
 * @param SortedListElement_t *element ... element to be removed
 *
 * @return 0: element deleted successfully, 1: corrtuped prev/next pointers
 *
 */
int SortedList_delete(SortedListElement_t *element) {
    if (element == NULL) {
        return 1;
    }

    if (element->next->prev != element || element->prev->next != element) {
        return 1;
    }

    if (opt_yield && DELETE_YIELD) {
        sched_yield();
    }

    SortedListElement_t *cur = element->next;
    SortedListElement_t *tmp = element->prev;

    cur->prev = tmp;
    tmp->next = cur;

    return 0;
}

/**
 * SortedList_lookup ... search sorted list for a key
 *
 *	The specified list will be searched for an
 *	element with the specified key.
 *
 * @param SortedList_t *list ... header for the list
 * @param const char * key ... the desired key
 *
 * @return pointer to matching element, or NULL if none is found
 */
SortedListElement_t *SortedList_lookup(SortedList_t *list, const char *key) {
    if (list == NULL || key == NULL) {
        return NULL;
    }

    SortedListElement_t *cur = list->next;

    while (cur != list) {
        if (strcmp(cur->key, key) == 0) {  //ascending so if values are > than key then its not in the list
            return cur;
        }

        if (opt_yield && LOOKUP_YIELD) {
            sched_yield();
        }

        cur = cur->next;
    }

    return NULL;
}

/**
 * SortedList_length ... count elements in a sorted list
 *	While enumeratign list, it checks all prev/next pointers
 *
 * @param SortedList_t *list ... header for the list
 *
 * @return int number of elements in list (excluding head)
 *	   -1 if the list is corrupted
 */
int SortedList_length(SortedList_t *list) {
    if (list == NULL || list->key != NULL) {
        return -1;
    }

    SortedListElement_t *cur = list->next;
    int count = 0;

    while (cur != list) {
        if (cur->next->prev != cur || cur->prev->next != cur) {
            return -1;
        }

        if (opt_yield && LOOKUP_YIELD) {
            sched_yield();
        }
        count++;
        cur = cur->next;
    }
    
    return count;
}