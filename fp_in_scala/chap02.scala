// exercises from chapter 2 of funcprog in scala


object Exercise_1 {
  // build an iterative fib function...

  def fib( n:Int ):Int = {

    @annotation.tailrec
    def iter( idx:Int, n1:Int, n2:Int ):Int = {
      if ( idx == n ) n1
      else iter( idx+1, n1+n2, n1 )
    }

    n match {
      case 0 => 0
      case 1 => 1
      case _ => iter( 2, 1, 1 )
    }

  }

}

object Exercise_2 {

  // build issorted, which checks whether an Array[A]
  // is sorted according to given criteria

  def isSorted[A]( a:Array[A], gt:(A,A) => Boolean ):Boolean = {

     def sortedAccum( x:Tuple2[Boolean,A], y:A ) = x match {
        case (true,num) => ( gt(num,y) , y )
        case _          => ( false, y ) 
     }

     a.foldLeft( ( true, a(0) ) )(sortedAccum)._1
  }

}


object Exercise_3 {

  // define partial1 (signature given) and a use of it

  def partial1[A,B,C]( a:A , f:(A,B)=>C ):B=>C = {
    (b:B) => f(a,b)
  }

  def use = {
     println(partial1(2, (a:Int,b:Int) => a+b)(4)) // should print 6
  }
}


object Exercise_4 {

  // define curry (signature given)

  def curry[A,B,C](f:(A,B)=>C):A => (B => C) = {
    (a) => { (b) => f(a,b) }
  }

}

object Exercise_5 {

  // define uncurry (signature given)

  def uncurry[A,B,C](f: A => B => C):(A,B) => C = {
     (a,b) => f(a)(b)
  }

}


object Exercise_6 {
  
  // define a compose function

  def compose[A,B,C](f: B => C, g: A => B): A => C = {
     (a) => f(g(a))
  }
}
