// a fun program to determine which 
// four prices add up to $7.11 and also
// have $7.11 as their product.  As seen on
// https://wrongsideofmemphis.wordpress.com/2017/02/11/7-11-in-four-prices-and-the-decimal-type-revisited/

package main

import (
	"fmt"
	"os"
)

func main() {

	for w := 0 ; w <= 711 ; w++ {
		for x := 0 ; x <= 711 - w ; x++ {
			for y := 0 ; y <= 711 - w - x ; y++ {
				z := 711 - w - x - y 
				if w*x*y*z == 711000000 {
					fmt.Printf("%d %d %d %d\n",w,x,y,z)
					os.Exit(0)
				}
			}
		}
	}
	fmt.Println("none found.")
	os.Exit(1)
}
