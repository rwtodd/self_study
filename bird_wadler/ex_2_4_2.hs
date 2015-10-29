module Main where

-- given integer x, (y,z) is a pair of integers such that
--   * abs(y) <= 5
--   * x = y + 10 * z
--   * abs(z) is the smallest of all possible values that 
--       satisfy the other constraints 

-- So, y and z are uniquely determined by: 
--   * for z, pushing x to the nearest multiple of 10.
--     * if x ends in a 5, favor the smaller multiple in terms
--       of absolute value
--   * for y, make up the difference between x and z

split x = ( y, (x-y) `div` 10)
 where pos   =  x >= 0
       digit =  (abs x) `mod` 10 
       y     |  pos && digit < 6     = digit 
             |  pos                  = digit - 10
             |  not pos && digit < 6 = negate digit
             |  otherwise            = 10 - digit

