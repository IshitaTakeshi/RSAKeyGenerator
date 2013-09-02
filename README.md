Usage:

generate keys:  
	$ cd {project}  
	$ cd GenerateKeys/  
	$ ghc -o GenerateKeys GenerateKeys.hs  
	$ cd ../  
	$ GenerateKeys/GenerateKeys  

encryption:  
	$ cd {project}  
	$ python Cipher/encryption.py keys/publickey.csv <textfile>  

decryption:  
	$ cd {project}  
	$ python Cipher/decryption.py keys/privatekey.csv <"filename".encrypted>  
