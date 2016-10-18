// given in the text
trait RNG {
   def nextInt: (Int, RNG)
}

// given in the text
object RNG {
  def simple(seed: Long) : RNG = new RNG {
    def nextInt = {
       val seed2 = (seed*0x5DEECE66DL + 0xBL) & ((1L << 48) - 1)
       ((seed2 >>> 16).asInstanceOf[Int], simple(seed2))
    }
  }
}

// Exercise: define the function:
object ex6_1 {
  def positiveInt(rng: RNG): (Int, RNG) = {
     val (n, r) = rng.nextInt
     if (n == Int.MinValue) positiveInt(r)
     else (n.abs, r)
  }
}


// Exercise: define the function:
object ex6_2 {
  def double(rng: RNG): (Double, RNG) = {
     val (n, r) = ex6_1.positiveInt(rng)
     ( n.toDouble / Int.MaxValue , r )
  }
}

// Exercise: define the functions:
object ex6_3 {
  def intDouble(rng:RNG) : ((Int,Double), RNG) = {
     val (i, r) = rng.nextInt
     val (d, r2) = ex6_2.double(r)   
     ((i,d), r2)
  }

  def doubleInt(rng:RNG) : ((Double,Int), RNG) = {
     val ((i,d),r) = intDouble(rng)
     ((d,i),r)
  }

  def double3(rng:RNG) : ((Double, Double, Double), RNG) = {
     val (d1, r1) = ex6_2.double(rng)   
     val (d2, r2) = ex6_2.double(r1)   
     val (d3, r3) = ex6_2.double(r2)   
     ((d1,d2,d3), r3) 
  }
}


// Exercise: define the function:
object ex6_4 {
   def ints(count: Int)(rng: RNG): (List[Int], RNG) = count match {
         case 0 =>  (Nil, rng)
         case _ =>  val (i1, r1) = rng.nextInt 
                    val (lst, r2) = ints(count - 1)(r1)
                    (i1 :: lst, r2)
   }
}


// Given in the text
trait RandSt {
   type Rand[+A] = RNG => (A, RNG)
   val int: Rand[Int] = _.nextInt
   def unit[A](a: A): Rand[A] = rng => (a, rng)
   def map[A,B](s : Rand[A])(f: A => B): Rand[B] = 
       rng => {
           val (a, rng2) = s(rng)
           (f(a), rng2)
       }
}

// Exercise: implement the function:
object ex6_5 extends RandSt {
   def positiveMax(n: Int): Rand[Int] =
       map(int) { _ % (n+1) }
}

// Exercise: implement the function:
object ex6_6 extends RandSt {
   val double: Rand[Double] = map(int) { _.toDouble / Int.MaxValue }
}

// Exercise: implement the function:
object ex6_7 extends RandSt {
   def map2[A,B,C](ra: Rand[A], rb: Rand[B])(f: (A, B) => C): Rand[C] =
       rng =>  {
           val (v1, rng1) = ra(rng)
           val (v2, rng2) = rb(rng1)
           ( f(v1,v2), rng2 )
       } 

   val double: Rand[Double] = map(int) { _.toDouble / Int.MaxValue }
     
   val intDouble : Rand[(Int,Double)] = map2(int,double) { (_,_) }
   val doubleInt : Rand[(Double,Int)] = map2(double,int) { (_,_) }
}

// Exercise: implement the function:
object ex6_8 extends RandSt {
  def sequence[A](fs: List[Rand[A]]): Rand[List[A]] = rng => {
      fs match {
         case Nil      => (Nil,rng)
         case x :: xs  => ex6_7.map2(x, sequence(xs)) { _ :: _ } (rng)
      } 
  }
}

// Exercise: implement the functions:
trait Rand6_9 extends RandSt {
   def flatMap[A,B](f: Rand[A])(g: A => Rand[B]): Rand[B] = rng => {
      val (a, r1) = f(rng)
      g(a)(r1) 
   }
}

object ex6_9 extends Rand6_9 {
  val positiveInt : Rand[Int] = flatMap(int) { i =>
     if (i != Int.MinValue) unit(i.abs) else positiveInt
  }
}

// Exercise: implement in terms of flatMap
object ex6_10 extends Rand6_9 {
   override def map[A,B](s : Rand[A])(f: A => B): Rand[B] = 
      flatMap(s){ a => unit(f(a)) }

   def map2[A,B,C](ra: Rand[A], rb: Rand[B])(f: (A, B) => C): Rand[C] =
      flatMap(ra){ a => flatMap(rb){ b => unit(f(a,b)) } }
}


// Exercise 11: implement the basic operations on generalized state 
// Exercise 12: design and implement get and set...
case class State[S,+A](run: S => (A,S)) {
   def flatMap[B](g: A => State[S,B]) =
      State[S,B] { s => {
                 val (a, s1) = run(s)
                 g(a).run(s1) 
              }
      }

   def map[B](f: A => B): State[S,B] = 
      flatMap{ a => State.unit(f(a)) }

}

object State {
   def unit[S,A](a: A) = State[S,A]{ s => (a, s) }

   def map2[S,A,B,C](ra: State[S,A], rb: State[S,B])(f: (A, B) => C): State[S,C] =
      ra.flatMap{ a => rb.flatMap{ b => State.unit(f(a,b)) } }

   def get[S] : State[S,S] = State { s => (s,s) }
   def set[S](ns: S) : State[S,S] = State[S,S] { s => (s, ns) }

   def sequence[S,A](fs: List[State[S,A]]): State[S,List[A]] = State( s => {
      fs match {
         case Nil      => (Nil,s)
         case x :: xs  => (map2(x, sequence(xs)) { _ :: _ }).run(s)
      } 
    })
}

object RandState {
   val int = State( (r:RNG) => r.nextInt )
}



// Exercise 13:  implement a candy dispenser simulation
sealed trait Input
case object Coin extends Input
case object Turn extends Input

case class Machine(locked: Boolean, candies: Int, coins: Int) 

// - Inserting a coin into a locked machine will cause it to unlock if there is any candy left.
// - Turning the knob on an unlocked machine will cause it to dispense candy and become locked.
// - Turning the knob on a locked machine or inserting a coin into an unlocked machine does nothing.
// - A machine that is out of candy ignores all inputs.

object ex6_13 {
  // return the  number of coins at the end...
  def simulateMachine(inputs: List[Input]) : State[Machine, Int] = 
     State.sequence(inputs.map( x => x match {
                        case Coin => coinState
                        case Turn => turnState
                    })).flatMap( _ => getCoins)

  private val getCoins : State[Machine,Int] = State( m => (m.coins, m) )

  private val coinState : State[Machine,Unit] = State( m => {
     if(m.candies > 0) { 
          (Unit, Machine(false, m.candies, m.coins+1))
     } else {
          (Unit, m)
     }
  } )   

  private val turnState : State[Machine,Unit] = State( m => {
     if((m.candies > 0) && !m.locked) { 
          (Unit, Machine(true, m.candies-1, m.coins))
     } else {
          (Unit, m)
     }
  } )   
}
