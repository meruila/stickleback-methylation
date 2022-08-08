# DNA Methylation Profiling of Marine and Freshwater Stickleback
The project provides a recapitulation of the three-spine stickleback methylation analysis in freshwater and marine groups (Artemov et al., 2017). Data was retrieved from the National Center for Biotechnology Information (NCBI) through the Sequence Read Archive (SRA). All sequences can be found under BioProject accession ID [PRJNA776820](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA776820).  
This project only considers groups from freshwater fish in freshwater (F@F) and marine fish in marine water (M@M). The sequences used are SRR16676624-SRR16676627 (F@F) and SRR16676637-SRR16676640 (M@M). 
## Usage
Run the `00-main.sh` scripts in `01-get_reads`, `02-quality_control`, or `03-methylation_analysis`.
1. For `01-get_reads`, provide `-d`/`--dir` and `-r`/`--reads`.  
2. For `02-quality_control`, provide `-r`/`--reads` and `--fastp`/`--fastqc`. For Fastp, it is optional to provide the other parameters such as the file extensions and read identifiers.  
3. For `03-methylation_analysis`, provide `-d`/`--dir`, `-r`/`--reads`, and `--bis`/`--bsb`.
## Dependencies
### SRA Toolkit
This is used to process data from SRA. Under these tools, the `fasterq-dump` module is used to extract FASTQ data from SRA.  
To download the SRA Toolkit, visit its [wiki](https://github.com/ncbi/sra-tools/wiki/01.-Downloading-SRA-Toolkit). This [video](https://www.youtube.com/watch?v=FjYO6Ys5cpc) may also help in using the toolkit.
### Quality Control Tools
### *FastQC*
This is used to 
### *Fastp*
### Methylation Analysis Tools
### *Bismark*
### *BSBolt*
## References
### Main reference  
Artemov, A. V., Mugue, N. S., Rastorguev, S. M., Zhenilo, S., Mazur, A. M., Tsygankova, S. V., Boulygina, E. S., Kaplun, D., Nedoluzhko, A. V., Medvedeva, Y. A., & Prokhortchouk, E. B. (2017). Genome-Wide DNA Methylation Profiling Reveals Epigenetic Adaptation of Stickleback to Marine and Freshwater Conditions. *Molecular Biology and Evolution, 34*(9), 2203–2213. https://doi.org/10.1093/molbev/msx156 
### Technologies used
Chen, S., Zhou, Y., Chen, Y., & Gu, J. (2018). fastp: an ultra-fast all-in-one FASTQ preprocessor. *Bioinformatics (Oxford, England), 34*(17), i884–i890. https://doi.org/10.1093/bioinformatics/bty560
Farrell, C., Thompson, M., Tosevska, A., Oyetunde, A., & Pellegrini, M. (2021). BiSulfite Bolt: A bisulfite sequencing analysis platform. *GigaScience, 10*(5), giab033. https://doi.org/10.1093/gigascience/giab033
Krueger, F., & Andrews, S. R. (2011). Bismark: a flexible aligner and methylation caller for Bisulfite-Seq applications. *Bioinformatics (Oxford, England), 27*(11), 1571–1572. https://doi.org/10.1093/bioinformatics/btr167

