package com.waywardcode.numseries

import java.util.{Collections,Map,NavigableMap,TreeMap}
import java.math.BigInteger

// The Ulam Series from a,b... is defined as:  (https://oeis.org/A002858)
//    u(1) = a, u(2) = b  
//    u(n) = least number > a(n-1) which is the unique sum of two distinct 
//           earlier sums.
//
// The object/class below generates Ulam sequences of type Stream[BigInteger]
// Usage:   UlamSeries(1,2).take(10).toList // or whatever...
//
object UlamSeries {
   def apply(a: BigInteger, b: BigInteger) : Stream[BigInteger] = 
        new UlamSeries(a,b).series
   def apply(a: Int, b: Int) : Stream[BigInteger] = 
        apply( BigInteger.valueOf(a.toLong), BigInteger.valueOf(b.toLong) )
}

class UlamSeries private (a: BigInteger, b: BigInteger) {
     val series : Stream[BigInteger] = 
             a #:: 
             computeNext(a, new TreeMap[BigInteger, Int](Collections.singletonMap(b, 0)))  
         
     private def computeNext(largest : BigInteger, 
                             backlog : NavigableMap[BigInteger, Int]) 
           : Stream[BigInteger] = {
        // first add all values up to largest to the backlog
        series.takeWhile { e => (e compareTo largest) < 0 }
              .map { _.add(largest) }
              .foreach { sum =>
            // set the mapping to 1 if it's the only one, 2 if we've already seen it
            backlog.compute( sum, (k, v) => if (v == 0) 1 else 2 )
        }

        // skip backlog entries that were seen more than once
        var head = backlog.pollFirstEntry 
        while( head.getValue > 1 )  {
           head = backlog.pollFirstEntry
        } 

        // return the next element in the sequence
        head.getKey #:: computeNext( head.getKey, backlog )
     }
}

