# 3.3.x Exercises

## 3.3.1

Express #[e | x <- xs; y <- ys ] in terms of #xs and #ys

   #xs * #ys

## 3.3.2

Which of the following are true and false:

    [[]] ++ xs == xs       ;; false
    [[]] ++ xs == [xs]     ;; false
    [[]] ++ xs == [[],xs]  ;; false 
    [[]] ++ [xs] == [[],xs] ;; true
    [xs] ++ []  == [xs]     ;; true
     [xs] ++ [xs] == [xs,xs] ;; true

## 3.3.3

Characterize the finite lists xs and ys which satisfy:

    xs ++ ys == ys ++ xs

Answer: xs == ys, or xs == [], or ys = [],
   or... xs and ys are made up of a finite
   repetition.   Example:

    abc|abcabc == abcabc|abc

## 3.3.4

What is the value of [hd xs] ++ tl xs when xs == []?

Answer: Bottom.

## 3.3.5

Show that if p is the minimum of m and n, then:

    take m . take n == take p

Answer:  Keep in mind that `take 5` of a 4-element list 
gives the 4-element list.

So, two cases.  Case 1) m >= n.   Then the answer will be 
equivalent to take n, since the `take n` portion will leave
an n-element list, which `take m` will return as-is.

Case 2) m < n.  In this case, `take n` will give `take m` more
than enough elements, and we will be left with the first m.

In both cases, we are left with the first p elements, where 
p is the smaller of m and n.  Q.E.D.

## 3.3.6

Verify or disprove the assertion:

    (drop n xs)!m == xs!(n+m)

Answer:  it is correct. We could define `!` to drop 
elements one at a time if we wanted:

    xs ! 0 == hd xs
    xs ! n == tail xs ! (n-1)

...which makes it easy to see why the expressions are equivalent.

## 3.3.7

Is `zip` associative in the sense that:

    zip (xs, zip (ys,zs)) == zip( zip(xs,ys), zs )

Answer: no, because the pairs are associated differently. 
E.G., (1,(3,5)) vs ((1,3),5) 

## 3.3.8 

Use zip to define zip4 which converts 4-tuples of lists into a list of 
4-tuples.

Answer:

    zip4 (l1,l2,l3,l4) = [ (a,b,c,d) | 
                           ((a,b),(c,d)) <- zip (zip l1 l2) (zip l3 l4) ]

(using the haskell zip which takes two args instead of a tuple)

## 3.3.9

Define a function `trips` so that `trips xs` returns a list of all adjacent
triples of elements in xs.

    trips xs = [ (a,b,c) | (a,(b,c) <- zip xs 
                                           (zip (tail xs) 
                                                (tail $ tail xs)) ]

## 3.3.10

Suppose xs has an equal number of odd and even numbers. Define
`riffle` so that odds and evens alternate.

Answer:

Since we haven't gotten to `filter` yet in the book, I will play along
and not simply filter on odd and even.

    riffle xs = concat [ [a,b] | (a,b) <- zip [ e | e <- xs, even e ]
                                              [ o | o <- xs, odd  o ] ]

## 3.3.11

Find an xs and ys such that `(xs ++ ys) -- ys != xs`.

Answer: any list `ys` that has elements in `xs` will do, since it's
the elements of xs which will be deleted first.

## 3.3.12

Write a function to score Mastermind given the secret number
and a guess.

    score num guess = (bulls, cows)
      where
      bulls = length [ 1 | (a,b) <- zip num guess, a == b ]
      cows  = length num - length (num \\ guess) - bulls  

(I used the haskell Data.List (\\) for the textbook's (--) 
operator).

