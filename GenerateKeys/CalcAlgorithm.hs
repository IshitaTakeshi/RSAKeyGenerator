module CalcAlgorithm
(powMod
,inverse
) where

 
powMod :: Integer -> Integer -> Integer -> Integer
powMod base ex m
  | ex == 0   = 1
  | even ex   = square (powMod base (ex `div` 2) m) `mod` m
  | otherwise = (base * (powMod base (ex - 1) m)) `mod` m
 where
   square x = x * x


extEuclid a b = recurse a b 1 0 0 1
  where recurse a 0 x0 y0 x1 y1 = (x0, y0)
        recurse a b x0 y0 x1 y1 = let q = a `div` b in 
                                  let r = a `mod` b in
                                  recurse b r x1 y1 (x0 - q * x1) (y0 - q * y1)

inverse :: Integer -> Integer -> Integer
inverse x n = (fst (extEuclid x n)) `mod` n
