#! /bin/bash

#####################################################################
# Alignment and methylation analysis using BWAMeth and MethylDackel #
#####################################################################

R1_ID="_1"
R2_ID="_2"
EXT=".fastq"
READS_LOCATION="/media/tofumeow/Potato1/Bioinformatics/artemov_reads/fastq_reads_paired/"

start=`date +%s`

bwameth.py index /home/tofumeow/Documents/UPLB/PGC-Agriculture/Y3SM-Stickleback/reference-genome/Gasterosteus_aculeatus/G_Aculeatus-genome.fa

for r in $(ls $READS_LOCATION*$R1_ID$EXT)
  do
    FILE_W_EXT=${r#$READS_LOCATION}
    FILENAME=${FILE_W_EXT%$R1_ID$EXT}
    read1=$r
    read2=$READS_LOCATION$FILENAME$R2_ID$EXT
    # analysis using paired-end reads from stickleback
    bwameth.py --reference /home/tofumeow/Documents/UPLB/PGC-Agriculture/Y3SM-Stickleback/reference-genome/Gasterosteus_aculeatus/G_Aculeatus-genome.fa $read1 $read2 | samtools view -b - > $FILENAME.bam
    MethylDackel extract /home/tofumeow/Documents/UPLB/PGC-Agriculture/Y3SM-Stickleback/reference-genome/Gasterosteus_aculeatus/G_Aculeatus-genome.fa $FILENAME.bam
done

end=`date +%s`

runtime=$((end-start))
echo $runtime >> run_bwameth.txt 
