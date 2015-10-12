# Exercises 1.5.x

## 1.5.1

### Part 1
Specify the <code>isSquare</code> function. 

    For all integers a, isSquare (a*a).

### Part 2
Does the following fit the bill?

    isSquare x = (square (intsqrt x) == x)

Yes it will.

## 1.5.2

Specify the intsqrt function.

    intsqrt x = max { i | Integers : i*i <= x }

