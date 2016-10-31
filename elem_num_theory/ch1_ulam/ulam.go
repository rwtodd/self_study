package main

import (
	"fmt"
	"os"
	"strconv"
)

type OrderedQueue interface {
	Insert([]int64)
	PopInt() int64
}

// we will implement OrderedQueue as follows:
type oqEntry struct {
	key    int64 // the number
	unique bool  // false == seen more than once
}

type oqArray []oqEntry

func NewOrderedQueue() *oqArray {
	return &oqArray{}
}

func (q *oqArray) PopInt() int64 {
	idx := 0
	for !(*q)[idx].unique {
		idx++
	}
	ans := (*q)[idx].key
	*q = (*q)[idx+1:]
	return ans
}

// this is an n+m merge of the two arrays...
func (q *oqArray) Insert(keys []int64) {
	newq := make(oqArray, 0, len(keys)+len(*q))
	idxOQ, idxKeys := 0, 0

	for (idxOQ < len(*q)) && (idxKeys < len(keys)) {

		comparison := (*q)[idxOQ].key - keys[idxKeys]
		switch {
		case comparison == 0:
			(*q)[idxOQ].unique = false
			newq = append(newq, (*q)[idxOQ])
			idxOQ++
			idxKeys++
		case comparison < 0:
			newq = append(newq, (*q)[idxOQ])
			idxOQ++
		default:
			newq = append(newq, oqEntry{keys[idxKeys], true})
			idxKeys++
		}
	}

	// now copy any that were left...
	for _, v := range (*q)[idxOQ:] {
		newq = append(newq, v)
	}
	for _, v := range keys[idxKeys:] {
		newq = append(newq, oqEntry{v, true})
	}

	// set ourself to the new queue
	*q = newq
}

// generates an ulam sequence...
func ulam(port chan int64, first int64, second int64) {
	var q OrderedQueue = NewOrderedQueue()
	q.Insert([]int64{first, second})
	sofar := []int64{}

	for {
		nxt := q.PopInt()
		port <- nxt
		sums := make([]int64, len(sofar))
		for idx, sfval := range sofar {
			sums[idx] = nxt + sfval
		}
		q.Insert(sums)
		sofar = append(sofar, nxt)
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Need a number arg.")
		return
	}
	max, _ := strconv.Atoi(os.Args[1])
	fmt.Printf("Argument was %v\n", max)

	port := make(chan int64, 100)
	go ulam(port, 1, 2)

	count := 0
	for x := range port {
		count++
		if count == max {
			fmt.Printf("%d:\t%d\n", count, x)
			return
		}
	}
}
