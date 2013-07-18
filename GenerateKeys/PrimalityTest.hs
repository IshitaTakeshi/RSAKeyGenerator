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

factor2 :: Integer -> (Int, Integer)
factor2 n = factor2' (0,n)
  where
    factor2' (s,d)
      | even d    = factor2' (s + 1, d `div` 2)
      | otherwise = (s,d)

isProbablePrime :: Integer -> Integer -> Bool
isProbablePrime n a = 
  let (s,d) = factor2 (n - 1)
      aPowd = powMod a d n
      double x = powMod x 2 n
      evens = take s $ iterate double aPowd
  in aPowd == 1 || any (== n - 1) evens

isMillerRabinPrime :: Integer -> IO Bool
isMillerRabinPrime n = do
 ns <- genInfiniteRandomList
 return . and $ map (isProbablePrime n) (take 12 ns)

getPrime s = do
 if odd s then getPrime' s else getPrime (s+1)
  where getPrime' s = do b <- isMillerRabinPrime s
                         if b then return s else getPrime' (s+2)
