// -------------------- 
// Ex 1.11 -- calculate a function that's identity for inputs
// less than three, and equal to f(X-1)+2f(X-2)+3f(X-3) otherwise.
// We need to make both a recursive and iterative answer.
// -------------------- 

object SICP_01_11 {
  
  // recursive version pretty much matches the problem definition
  def f_rec( x: Int ): Int = {
    if ( x < 3 )  x 
    else f_rec( x-1 ) + 2*f_rec( x - 2 ) + 3*f_rec( x - 3 )
  }

  // iterative version counts up, remembering the last three
  // values of the function along the way.
  def f_iter( x: Int ) = {
     def iter( cur : Int, min1 : Int, min2 : Int, min3 : Int) : Int = {
        if ( cur == (x+1) )   min1
        else iter( cur+1, min1 + 2*min2 + 3*min3, min1, min2 )
     }

     if( x < 3 )  x 
     else  iter(3,2,1,0) 
  }
 
  def main( argv : Array[String] ) = {
    println( f_iter(17) )
    println( f_rec(17) )
  }
}
