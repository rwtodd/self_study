// ------------------------------------
// SICP 1.12 -- pascal triangle element
// ------------------------------------

object SICP_01_12 {
  def pascElem( row:Int, col:Int ) : Int = col match { 
     case 1 | `row`  => 1
     case _          => pascElem( row - 1, col ) + 
                        pascElem( row - 1, col - 1 ) 
  } 

 // should print 10
 def main( argv:Array[String] ) = println( pascElem( 6, 3 ) ) 

}
