module Random
(genSeed
,genInfiniteRandomList
)where

import System.Entropy
import System.Random
import Data.Time.Clock.POSIX
import Crypto.Hash.SHA512

genSeed :: IO Integer
genSeed = do
	mbstr <- getEntropy 128
	let str' = show $ hash mbstr	
	let str = map toEnum $ filter (\x -> 48<=x && x<58) $ map fromEnum $ str':: [Char]
	let randomNum = read str :: Integer
	return randomNum

--generate randoms between n1 and n2
genInfiniteRandomList :: (Integer, Integer) -> IO [Integer]
genInfiniteRandomList (n1, n2) = do
 g <- getPOSIXTime
 let randNum = randomRs (n1, n2) (mkStdGen (round g)) :: [Integer]
 return $ map toInteger randNum

