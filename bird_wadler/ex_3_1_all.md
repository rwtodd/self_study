# 3.1.x Exercises

## 3.1.1 

Give an example of an expression with 2 occurrences of empty list.
The first having type [num] and the second type [char].

Answer:

    if [1,2,3] == [] then "not" else []

## 3.1.2

Determine the number of elements [a..b] and [a,b..c] in terms 
of a, b and c.

    #[a..b]   == b - a + 1
    #[a,b..c] == (c - a) `div` (b - a) + 1

