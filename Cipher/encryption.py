from __future__ import division
from decimal import Decimal
import csv
import sys
import os.path

usage = """Usage: python encryption.py [FILEPATH] [FILEPATH] 
example: python encryption.py publickey.csv text"""

if(len(sys.argv) < 3):
	print(usage)
	sys.exit()

filepath_pubkey = sys.argv[1]
with open(filepath_pubkey) as file_pubkey:
	for row in csv.reader(file_pubkey):    
		if(row[0] == 'n'):
			n = int(row[1]) 
		elif(row[0] == 'e'):
			e = int(row[1])

try:
	n,e
except NameError:
	print("File error")

filepath_in = sys.argv[2]
filesize_bits = os.path.getsize(filepath_in) * 8
print("the size of file: %dbits"%filesize_bits)
print("the length of n: %dbits"%(len(bin(n))-2))
	
if(filesize_bits > len(bin(n))-5):
	print("the file is too large")
	sys.exit()

with open(filepath_in) as infile:
	text = infile.read()

	asciitext = int(text.encode("hex"), 16)
	while asciitext < pow(n, Decimal(1/e)):
		text += "PADDING"
		asciitext = int(text.encode("hex"), 16)
	
with open("text.encrypted", "w") as outfile:
	c = pow(asciitext,e,n)
	outfile.write(str(c))			
