package main

import (
 "os"
"fmt"
"strconv"
 "container/heap"
)

// generates an ulam sequence...
func ulam(port chan int, first int, second int) {
   h := &IntHeap{first,second}
   heap.Init(h)
   sofar := []int{}

   for {
      nxt := h.NextUnique()
      port <- nxt
      for _,y := range sofar {
           heap.Push(h,nxt + y)
      }
      sofar = append(sofar,nxt)
   } 
}


func main() {
   if len(os.Args) < 2 {
      fmt.Println("Need a number arg.")
      return
   }
   max,_ := strconv.Atoi(os.Args[1])
   fmt.Printf("Argument was %v\n", max)

   port := make(chan int,100) 
   go ulam(port,1,2)

   count := 0
   for x := range port {
      count++
      if count == max { 
         fmt.Printf("%d:\t%d\n",count, x)
         return
      }
   }
}


// the heap came from the package examples... I only 
// hacked together a NextUnique method.
// It would probably be much better to make an actual
// ordered tree so I could keep a count rather than storing
// duplicates 

// An IntHeap is a min-heap of ints.
type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
// Push and Pop use pointer receivers because they modify the slice's length,
// not just its contents.
*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
old := *h
n := len(old)
x := old[n-1]
*h = old[0 : n-1]
return x
}

// Get the next item from the heap that is unique in the heap,
// remove and return it.
func (h *IntHeap) NextUnique() int {
  //step 1 get a value
  var x int = heap.Pop(h).(int)

  for {
     // step 2: was it the last one?  good...
     if h.Len() == 0 { return x }

     // step 3:  get another value...
     var y int = heap.Pop(h).(int)

     // step 4:  if they don't match, put second back and return first...
     if( x != y ) {
        heap.Push(h,y)
        return x
     }

     // step 5: if they did match ... soak up remaining matching values...
     for (x == y)  {
        x = heap.Pop(h).(int)
     }
   }
}  

