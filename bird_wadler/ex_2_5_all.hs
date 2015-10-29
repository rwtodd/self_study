module Main where

-- 2.5.1 : define versions of "and" and "or" with patterns on second arg

and1 a True  = a
and1 _ False = False

or1 _ True  = True
or1 a False = a

-- and now define them with patterns in both args

and2 True True   = True
and2 True False  = False
and2 False True  = False
and2 False False = False

or2 True True   = True
or2 True False  = True
or2 False True  = True
or2 False False = False


--  2.5.2 : is pred in the text equivalent to:
--     pred n = 0   , if n == 0
--     pred n = n-1 , if n > 0

-- Answer:  YES, it is.  And if fact, haskell does not
-- support the (n+1) patterns anymore, I don't think,
-- so I hope exercises don't depend too much on them!

