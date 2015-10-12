module Main where

-- using given square, create a quad function for x^4
square x = x * x

quad = square . square
