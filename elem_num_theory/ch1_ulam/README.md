# Ulam Series

~~~~~~
Welcome to Scala 2.12.0-RC2 (Java HotSpot(TM) 64-Bit Server VM, Java 1.8.0_101).
Type in expressions for evaluation. Or try :help.

scala> import com.waywardcode.numseries._
import com.waywardcode.numseries._

scala> val us = UlamSeries(1,2)
us: Stream[java.math.BigInteger] = Stream(1, ?)

scala> us.take(100).toList
res0: List[java.math.BigInteger] = List(1, 2, 3, 4, 6, 8, 11, 13, 16, 
18, 26, 28, 36, 38, 47, 48, 53, 57, 62, 69, 72, 77, 82, 87, 97, 99, 102, 
106, 114, 126, 131, 138, 145, 148, 155, 175, 177, 180, 182, 189, 197, 
206, 209, 219, 221, 236, 238, 241, 243, 253, 258, 260, 273, 282, 309, 
316, 319, 324, 339, 341, 356, 358, 363, 370, 382, 390, 400, 402, 409, 
412, 414, 429, 431, 434, 441, 451, 456, 483, 485, 497, 502, 522, 524, 
544, 546, 566, 568, 585, 602, 605, 607, 612, 624, 627, 646, 668, 673, 
685, 688, 690)

scala> Series.consecutives(us.take(100000)).toList
res1: List[(java.math.BigInteger, java.math.BigInteger)] = List((1,2), (2,3), (3,4), (47,48))
~~~~~~
