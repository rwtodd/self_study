module Main where

-- calculate the sum of the squares of the largest two 
-- inputs

sumsqrs a b c | a > b     = sq a + sq (max b c)
              | otherwise = sq b + sq (max a c)
  where sq x = x * x

