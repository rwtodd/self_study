package com.waywardcode.numseries

// some useful functions for dealing with series...

import java.math.BigInteger

object Series {
  import BigInteger.ONE

  // show adjacent differences in the stream
  def diffs(s : Stream[BigInteger]) : Stream[BigInteger] = s.tail.zip(s).map { case (y,x) => y.subtract(x) } 

  def pairsWithin(s: Stream[BigInteger], delta: BigInteger) : Stream[(BigInteger,BigInteger)] = 
     s.zip(diffs(s)).filter { _._2.compareTo(delta) <= 0 }.map { case (n,d) => (n, n.add(d)) }

  def pairsWithin(s: Stream[BigInteger], delta: Long) : Stream[(BigInteger,BigInteger)] = 
     pairsWithin(s, BigInteger.valueOf(delta))

  // show pairs of consecutive numbers in the stream
  def consecutives(s: Stream[BigInteger]) = pairsWithin(s, ONE) 
}
