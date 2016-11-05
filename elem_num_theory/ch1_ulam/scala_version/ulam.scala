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


// Here is an alternate implementation which is much faster and less memory-intensive.
// It creates an Iterator[Long], and keeps track of the backlog via ArrayBuffers.
// The strategy is modeled after the Go implementation.
class UlamIt(one: Long, two:Long) extends Iterator[Long] {
   import scala.collection.mutable.ArrayBuffer
   type BLEntry = Tuple2[Long,Boolean]
   
   private val sofar = ArrayBuffer[Long](one)
   private var backlog = ArrayBuffer[BLEntry]( (two, false) ) 
   private var first = true

   private def mergeNew(sums: ArrayBuffer[Long]) : Unit = {
      val merged = new ArrayBuffer[BLEntry]()
      merged.sizeHint(backlog.size + sofar.size)

      var sIdx = 0 
      var bIdx = 0
      while (bIdx < backlog.size) {
         (backlog(bIdx)._1 - sums(sIdx)) match {
         case 0 =>  merged += new BLEntry( backlog(bIdx)._1, true )
                    bIdx += 1
                    sIdx += 1
         case x if x < 0 => merged += backlog(bIdx)
                            bIdx += 1
         case _  => merged += new BLEntry(sums(sIdx), false)
                    sIdx += 1
         }
      } 
      merged ++= sums.view(sIdx, sums.size).map { v => (v,false) }
      backlog = merged
   }

   private def popBacklog() : Long = {
      val which = backlog.indexWhere( { bl => bl._2 == false } )
      val ans = backlog(which)._1
      backlog = backlog.drop(which+1)
      ans
   }

   override def hasNext() = true 
   override def next() : Long = {
       if(first) { first = false; return sofar(0) }

       val nxt = popBacklog()
       mergeNew( sofar.map { _ + nxt } )
       sofar += nxt
       nxt 
   } 
}
