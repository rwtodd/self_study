// --------------------------------------------------------
// 1.8 -- use newton's method to approximate the cube root
// of a number
// --------------------------------------------------------
object SICP_01_08 {
  def cubeRoot( x: Double ) = {

     def isGoodEnough( g1: Double, g2: Double ) = 
       ((g1-g2)/g1).abs < 0.0001 

     def cubeRootIter( guess: Double ): Double = {
       val guess2 = ( x/(guess*guess) + 2*guess ) / 3

       if (isGoodEnough(guess, guess2)) guess2 
       else  cubeRootIter(guess2) 
     }

     cubeRootIter( x / 10 )
  }

  def main( argv: Array[String] ) = print(cubeRoot(27.0))
}
