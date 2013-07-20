module PrimalityTest
(isMillerRabinPrime
,isProbablePrime
,getPrime
) where

import Control.Applicative
import Control.Monad
import System.Random
import Data.Time.Clock.POSIX
import CalcAlgorithm
import Random

factor2 :: (Integral t, Num t1) => t -> (t, t1)
factor2 x = factor2' (x,0)
 where
  factor2' (n,s)
   | even n = factor2' (n `div` 2, s+1)
   | otherwise = (n,s)

isProbablePrime :: Integer -> Integer -> Bool
isProbablePrime n a =
 let (d,s) = factor2 (n-1) in
 let p = powMod a d n /= 1 in
 let q = not $ elem (n-1) $ map (\r -> powMod a ((power 2 r)*d) n) [0..s-1] in
 not (p && q)


isMillerRabinPrime :: Integer -> IO Bool
isMillerRabinPrime n = do
 ns <- genInfiniteRandomList (1,n-1) 
 return . and $ map (isProbablePrime n) (take 12 ns)

getPrime :: Integer -> IO Integer
getPrime s = do
 if odd s then getPrime' s else getPrime (s+1)
  where getPrime' s = do b <- isMillerRabinPrime s
                         if b then return s else getPrime' (s+2)
