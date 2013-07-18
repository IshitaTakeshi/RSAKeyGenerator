import System.Random
import System.Environment
import System.Directory
import PrimalityTest 
import CalcAlgorithm
import Random

main = do

 seed1 <- genSeed
 seed2 <- genSeed
 
 p <- getPrime seed1
 q <- getPrime seed2 

 let n = p*q
 let e = head $ filter (/=0) $ map (\x -> if gcd x ((p-1)*(q-1)) == 1 then x else 0) [3..]
 let d = inverse e ((p-1)*(q-1))
 
 createDirectoryIfMissing True "keys"
 let filepath_pubkey = "keys/publickey.csv" :: FilePath
 let filepath_prikey = "keys/privatekey.csv" :: FilePath
 
 writeFile filepath_pubkey ("n," ++ (show n) ++ "\n" ++ "e," ++ (show e))
 writeFile filepath_prikey ("n," ++ (show n) ++ "\n" ++ "d," ++ (show d)) 
