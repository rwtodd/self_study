module Main where

-- calculate age in years based on two tuple inputs

age (bd,bm,by) (cd,cm,cy) | cm > bm              = cy-by 
                          | cm == bm && cd >= bd = cy-by
                          | otherwise            = cy - by - 1

