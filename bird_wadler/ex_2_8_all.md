# 2.8.x Exercises

## 2.8.1

Deduce the types:

a) `const x y = x`

    x :: t1
    y :: t2
    const :: t1 -> t2 -> t1

So: `a -> b -> a`

b) `subst f g x = f x (g x)`

(at this point I note these are the famous S and K combinators.)

    f :: t1
    g :: t2
    x :: t3
    f x (g x) :: t4
    subst :: t1 -> t2 -> t3 -> t4
    
    (g x) :: t5
    f x :: t5 -> t4
    
    g :: t3 -> t5
    f :: t3 -> t5 -> t4
    
    so subst :: (t3->t5->t4) -> (t3->t5) -> t3 -> t4

So: `(a->b->c) -> (a->b) -> a -> c`

c) `fix f x = f (fix f) x`

    f : t1
    x : t2
    f (fix f) x : t3

    fix :: t1 -> t2 -> t3

    f (fix f) :: t2 -> t3
    (fix f) :: t4
    f :: t4 -> t2 -> t3
    (fix f) :: t2 -> t3

    fix :: ((t2 -> t3) -> t2 -> t3) -> t2 -> t3

so `( (a -> b) -> a -> b ) -> a  -> b`

## 2.8.2

Show that `subst const const` is equal to `id`.

    subst const const x
    =  { application of subst }
    const x (const x)
    =  { application of const }
    x

Part 2) How to express composition in terms of subst and const?

    subst (const f) g x
    =  { application of subst }
    (const f) x (g x)
    =  { application of const }
    f (g x)

## 2.8.3

Define a function `apply` which applies a function to an 
argument. What is its type?

    apply f x = f x

Or, if they assumed we'd use the combinators:

    apply f = subst (const . f) const

Either way, the type is `(a -> b) -> a -> b`

## 2.8.4

Given `query f x g = g f (f x g)`, is there a sensible type for it?

    f :: t1
    x :: t2
    g :: t3
    g f (f x g) :: t4
    query :: t1 -> t2-> t3 -> t4
    
    (f x g) :: t5
    g f :: t5 -> t4
    g :: t1 -> t5 -> t4
    f x :: (t1 -> t5 -> t4) -> t5
    f :: t2 -> (t1 -> t5 -> t4) -> t5

... but f is also t1, so the last definition above infinitely
recurses on expansions of t1.  Therefore, there is no type 
for `query`.

