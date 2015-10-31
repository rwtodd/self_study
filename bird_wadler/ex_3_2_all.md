# 3.2.x Exercises

## 3.2.1

Evaluate `[j | i <- [1,-1,2,-2]; i > 0; j <- [1..i]]`

    [1,1,2]

## 3.2.2

Under what conditions on xs and ys does the equation:

    [x | x <-xs; y <- ys] = [x| y<-ys; x<-xs]

hold?

Answer:  xs has some multiple of a single element, or ys is empty

## 3.2.3

Define a function for counting the number of negative elements in a list
with a comprehension.

    numneg ls = sum [ 1 | x <- ls ; x < 0 ]

## 3.2.4

Define a function `intpairs` so that `(intpairs n)` is a list of all
distinct paris of integers 1 <= x, y <= n.

Answer: This question is a little ambiguous. I take "distict" to mean
that: if I have (1,2) then I shouldn't have (2,1).   I also assume the
notation means that both x and y are <= n.

    intpairs n = [ (x,y) | x <- [1..n] ; y <- [x..n] ]

## 3.2.5

Write a program to find quadruples (a,b,c,d) in the range
0 < a,b,c,d <= n such that `a^2+b^2=c^2+d^2`:

    quads n = [ (a,b,c,d) | a<-[1..n], b<-[1..n], c<-[1..n], d<-[1..n],
                            a*a+b*b == c*c+d*d ]

## 3.2.6

Define x^n using list comprehension.

    power x n = product [ x | y <- [1..n] ]

## 3.2.7

Determine the value of `(divisors 0)`, where:

    divisors n = [ d| d <-[1..n]; n mod d = 0 ]

Answer: []

## 3.2.8

Define a function mindivisor which reutrns the smallest 
divisor, greater than 1, of a given positive integer. 
Construct a function with it to tell if a number is 
prime.

    mindivisor = hd . tl . divisors
    is_prime x = mindivisor x == x

## 3.2.9

Define `gcd` to allow for zero arguments.

Answer: Not sure what this means, so I'll skip it.

## 3.2.10

Show that if n has a divisor 1 < d < n, then it has one in the
range 1 < d <= sqrt(n)

Answer:
Case 1:  The divisor is <= sqrt(n).
This is the trivial case, as the divisor itself is evidence.

Case 2: The divisor is > sqrt(n).
In this case n / d is another divisor, by the definition of a
divisor.  Furthermore, given that d > sqrt(n), the other 
divisor must be less than sqrt(n) (since sqrt(n)^2 == n). Therefore
n / d is the divisor <= sqrt(n) we needed to find.



