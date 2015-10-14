module Main where

import Data.Char (ord,chr)

-- 2.3.1 define nextlet, which gives the next letter of the alphabet

nextlet 'Z' = 'A'
nextlet x = chr . (+1) . ord $ x

-- 2.3.2 define digitval which converts a digit character to its numberical
-- value

digitval d | '0' <= d && d <= '9' = (ord d) - (ord '0')

-- 2.3.5 define total versions of the justification functions.


space x = take x $ repeat ' '

ljustify n x = x ++ (space $ max (n - m) 0)
  where m = length x

rjustify n x = space (max (n - m) 0) ++ x
  where m = length x

cjustify n x = space lm ++ x ++ space rm
  where m  = length x
        lm =  max 0 $ (n - m) `div` 2
        rm =  max 0 $ (n - m - lm)

