# Exercises 2.6.x

## 2.6.1 

given `h x y = f (g x y)`, which are true:

  - `h = f . g`
  - `h x = f . (g x)`
  - `h x y = (f . g) x y`

Answer: all three are true.

## 2.6.2

Give a function `num -> num` which gives no well-defined values.

Answer:  f x = f x

## 2.6.3 if `halve = (div2)` can you specify a function satisfying:

    f (halve x) = x

... for all numbers x?  Answer: Nope, because integer 
division loses information.  Example x = 4 and x = 5 both 
lead to `f 2`.

Part 2: Give a function that satisfies:

    halve (f x) = x

Answer: `f = (2*)`

## 2.6.4

If f and g are strict, show that (f.g) is strict.
Answer:  Not sure, but this seems to be completely
obvious. The combined function will be strict in the
argument because g is strict, and the continued processing
will be strict in g's result because f is strict.

## 2.6.5

Define `and` and `or` using only the function `cond` given
in the text.

    and x y = cond x y False

    or x y = cond x True $ cond y True False



