import pysam
import sys
import os


bamFile = sys.argv[1].strip()
sample = os.path.basename(bamFile)

bam = pysam.AlignmentFile(bamFile, "rb")

out_meth = pysam.AlignmentFile("../1.bam_c2t/"+sample, "wb", template=bam)
out_unmeth = pysam.AlignmentFile("../1.bam_non_c2t/"+sample, "wb", template=bam)
try:
	with bam as read:
		while True:
			read1 = read.next()
			read2 = read.next()
			if read1.query_name == read2.query_name:
				if read1.get_tag("XM").isupper() and read2.get_tag("XM").isupper():
					out_unmeth.write(read1)
					out_unmeth.write(read2)
				else:
					out_meth.write(read1)
					out_meth.write(read2)
			else:
				print  "unpaired read:" + read1.query_name
				exit()
except StopIteration:
	print "Done"
	
out_unmeth.close()
out_meth.close()
