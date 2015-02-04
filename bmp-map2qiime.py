#!/usr/bin/python
# Converts readmap.uc file from otupipe.bash into QIIME OTU map.
#
#Modified otupipe readmap2qiime.py script [http://www.drive5.com/usearch/manual/otupipe.html]

##Leandro Nascimento Lemos
##Victor Pylro
##Luiz Roesch
##17-04-2014 versao0.1
#QiimeToUparse
#How to use this script?
#python map2qiime.py map.uc > otu_table.txt



OTU_PREFIX="OTU"

import sys

UCFileName = sys.argv[1]
File = open(UCFileName)

n = len(OTU_PREFIX)
OTUToReads = {}
LineNr = 0
while 1:
	Line = File.readline()
	if len(Line) == 0:
		break
	Line = Line.strip()
	LineNr += 1
	if Line[0] == '#':
		continue
	Fields = Line.split("\t")
	if len(Fields) < 10:
		print >> sys.stderr, "Line %d in .uc file has < 10 fields" % LineNr
		sys.exit(1)

	if Fields[0] != 'H':
		continue

	ReadLabel = Fields[8]
	TargetLabel = Fields[9]
	

	if not TargetLabel.startswith(OTU_PREFIX):
		continue
	
	nome = "OTU"
#	OTU = int(nome) + int(TargetLabel[n:])
	OTU = nome + (TargetLabel[n:])	
	try:
		OTUToReads[OTU].append(ReadLabel)
	except:
		OTUToReads[OTU] = [ ReadLabel ]

for OTU in OTUToReads.keys():
	sys.stdout.write(str(OTU))
	for ReadLabel in OTUToReads[OTU]:
		sys.stdout.write("\t" + ReadLabel)

	sys.stdout.write("\n")
