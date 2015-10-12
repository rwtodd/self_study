# Exercises 1.2.x

## 1.2.1
How many ways can <code>square (square (3+7))</code> be reduced?

Well...  tons of ways...

  - +,square,*,sqaure,*
  - +,square,square,*'s
  - square, square,square, +'s and *'s in lots of combinations.
  - square, +,+,* square, *
  - etc.

I know that seems like a cop-out, but I don't see the educational 
value in enumerating all of these manually.


## 1.2.2
Considering <code>three x = 3</code>, how many ways can 
<code>three (3+4)</code> be reduced?

This is better...

  - +, three
  - three

... so 2 ways.

## 1.2.3
### Part 1
If zero is an expression, and forall expressions <i>e</i>, 
(pred e) and (succ e) are expressions, and if we have the following
two reduction rules:

 - succ . pred = id
 - pred . succ = id

... then simplify the expression: <code>(succ (pred (succ (pred (pred zero)))))
</code>

So, the answer is ... (pred zero), given than all the (pred . succ) pairs 
cancel out.

### Part 2
How many ways can the expression be reduced?  
I think three... 

  - Outer s.p, Inner s.p
  - Inner s.p, Outer s.p
  - Inner p.s, Outer p.s

I don't see any other obvious approaches.

### Part 3
Adding the syntax rule forall expressions <i>e1</i> and <i>e2</i>, then
<code>add e1 e2</code> is an expression.  The reduction rules are:

  - add zero e2 = e2
  - add (succ e1) e2 = (succ (add e1 e2))
  - add (pred e1) e2 = (pred (add e1 e2))

Again, they want me to count the ways to reduce 
  <code>(add (succ (pred zero)) zero)</code>. There
aren't too many:

  - s.p=id, addzero
  - addsucc, addpred, addzero, s.p=id
  - addsucc, addpred, s.p=id, addzero

... would be the three main ways.  

All roads lead to: <code>zero</code>

Prove that the reduction process terminates.  Well... <em>informally</em>,
reduction can't go on forever, becasue all of the rules lead to an expression
that is either the same size (add.2 add.3), or a smaller size (add.1, succ.1,
pred.1).  Further, the same-size rules cannot "loop" because they change the
expression into a form that is incompatible with re-application.  Therefore, by
applying reduction to a finite expression, you will eventually run out of rules
to apply.

## 1.2.4
Language: finite sequences of 1's and 0's. Reduction rules:

  - 1??x => x1101  (r1)
  - 0??x => x00    (r2)

Reduce 1110 to canonical form:

  1. 1110 
  2. 01101  by r1
  3. 0001   by r2
  4. 100    by r2

Reduce 10 to canonical form.  Already there.

Reduce 1110100 to canonical form.

  1. 1110100
  2. 01101100
  3. 0001100
  4. 100100
  5. 1110100
  6. 01101100 
  7. 0001100
  8. 100100

... and we have a cycle.


