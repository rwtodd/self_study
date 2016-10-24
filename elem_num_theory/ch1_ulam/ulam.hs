-- the Ulam Sequence, from any seed a, b
ulam :: Integer -> Integer -> [Integer]
ulam a b = 
  -- we start the computation off with the given 'a', seeding the backlog with 'b'
  let nums                    = a : nextUlam a [(b, True)]
      nextUlam recent backlog = 
          let -- extract the next Ulam sequence value, and the remaining backlog
              (minNum, rest)  = getMin (merge nextBatch backlog)  
                                  where -- a helper function to extract the minimum backlog entry with snd == True,
                                        -- discarding entries until a proper one is found
                                        getMin bl = let skipped = dropWhile (\(_,use) -> not use) bl
                                                    in ((fst . head) skipped, tail skipped) 

                                        -- the next group of numbers to add to the backlog
                                        nextBatch = map (+ recent) $ takeWhile (< recent) nums

                                        -- merge a new batch of numbers with an existing backlog 
                                        -- anything that matches gets a snd of False
                                        merge [] bl = bl 
                                        merge x  [] = map (\v -> (v,True)) x
                                        merge xl@(x:xs) bl@((b,_):bs)
                                           | x == b    = (x,False) : merge xs bs 
                                           | x <  b    = (x,True)  : merge xs bl 
                                           | otherwise = (head bl) : merge xl bs 

              -- the return value is the next number int he sequence, and a recursive call to
              -- continue the computation
              in minNum : nextUlam minNum rest

      -- return the list we are generating
      in nums

