import qualified Data.Map as M

-- the Ulam Sequence, from any seed a, b

ulam :: Integer -> Integer -> [Integer]
ulam a b = 
  -- we start the computation off with the given 'a', seeding the backlog map with 'b'
  let nums = a : nextUlam a (M.singleton b 1)
      nextUlam recent backlog = 

              -- the next group of numbers to add to the backlog
          let nextBatch             = map (+ recent) $ takeWhile (< recent) nums

              -- a helper function to merge keys into the backlog, maxing out the
              -- value at 2... so we never overflow 
              mergeKeys key mapping = M.insertWith (\_ _ -> 2) key 1 mapping

              -- this is teh backlog, with the extra keys added
              updated               = foldr mergeKeys backlog nextBatch 

              -- a helper function to extract the minimum key from the map with value == 1,
              -- discarding entries until a proper one is found
              getFirst mapping      = case (M.minViewWithKey mapping) of
                                         Just ((x,y), r) -> if y == 1 then (x,r) else getFirst r
                                         Nothing         -> error "ran out of keys!!!"

              -- use getFirst to extract the next Ulam sequence value
              (minKey, rest)        = getFirst updated  

              -- the return value is the next number int he sequence, and a recursive call to
              -- continue the computation
              in minKey : nextUlam minKey rest

      -- return the list we are generating
      in nums
