# Exercises 2.1.x

# 2.1.1

div/mod = q/r in:  x = q * y + r  ; (0 <= r < y)

What is the value of the following expressions, if 
`div` and `*` have the same binding power and are
left-associative?

    3 div 1 * 3 ==> 9
    3 * 7 div 4 ==> 5
    6 div 2 * 8 div 4 ==> 6

# 2.1.2

Show that for all positive x, y, and z:

    1)  (x + y) mod z == (x mod z + y mod z) mod z

    (x mod z + y mod z) mod z
    =   {def of modulus}
    (x - xdivz*z + y - ydivz*z) mod z
    =   {arithmetic}
    (x + y - xdivz*z - ydivz*z) mod z
    =   {arithmetic}
    (x + y + z*(- xdivz - ydivz)) mod z
    =   {mod z erases multiples of z}
    (x + y) mod z

    2)  x*(y mod z) == (x*y) mod (x*z)

    (x*y) mod (x*z)
    =  {def of modulus}
    (x*y) - (x*y div x*z)
    =  {arithmetic}
    x * (y - y div z)
    =  {def of modulus}
    x * (y mod z)

## 2.1.3

Prove that:

    1) x div 2 + (x+1) div 2 == x

    Case 1: x is even...
    x div 2 + (x+1) div 2 == x
    =  { (div 2) == (/2) when x even
    x/2 + (x+1) div 2
    =  { (y div 2) == (y-1)/2 when y is odd }
    x/2 + x/2
    =  { arithmetic }
    x

    Case 2: x is odd...
    x div 2 + (x+1) div 2 == x
    =  { (x div 2) == ((x-1)/2) when x odd
    (x-1)/2 + (x+1) div 2
    =  { (y div 2) == (y)/2 when y is even }
    (x-1)/2 + (x+1)/2
    =  { arithmetic }
    x

    Q.E.D.
 
 
    2) (x*y) div y == x

    (x*y) div y
    =  { definition of div }
    (x*y - (x*y mod y)) / y 
    =  { modulus y removes multiples of y }
    (x*y - 0) / y
    =  { arithmetic }
    x


    3) (x div y) div z == x div (y*z)

    skipped

## 2.1.4

What is (+(-x))?  It's subtraction.

## 2.1.5

For what arguments do the following return True?

    (= 9) . (2+) . (7*)    ; answer is:  1

    (3 >) . (mod 2)        ; answer is: all integers

## 2.1.6
Which of the following are true?

    (*) x = (*x)    true, commutative multiplication
    (+) x = (+x)    true, commutative addition
    (-) x = (-x)    NOT true

