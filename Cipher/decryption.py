import csv
import sys

usage = """Usage: python decryption.py [FILENAME] [FILEPATH]
example: python decryption.py privatekey.csv text.encrypted"""

if(len(sys.argv) < 3):
	print(usage)
	sys.exit()

filepath_pubkey = sys.argv[1]
with open(filepath_pubkey) as file_pubkey:
    for row in csv.reader(file_pubkey):    
        if(row[0] == 'n'): 
            n = int(row[1])  
        elif(row[0] == 'd'): 
            d = int(row[1])

try:
	n,d
except NameError:
	print("File error")


filepath_cipher = sys.argv[2]
with open(filepath_cipher) as file_cipher:
	cipher = file_cipher.readline()	
c = int(cipher)
m = pow(c,d,n)
print ("%0512x"%m).decode("hex")
