module Random
(genSeed
,genInfiniteRandomList
)where

import System.Entropy
import System.Random
import Data.Time.Clock.POSIX

genSeed :: IO Integer
genSeed = do
	mbstr <- getEntropy 128
	let str' = show mbstr	
	let str = map toEnum $ filter (\x -> 48<=x && x<58) $ map fromEnum $ str':: [Char]
	let randomNum = read str :: Integer
	return randomNum

genInfiniteRandomList :: IO [Integer]
genInfiniteRandomList = do
 g <- getPOSIXTime
 let randNum = randoms (mkStdGen (round g)) :: [Int]
 return $ map toInteger randNum

