# DNA Methylation Profiling of Marine and Freshwater Stickleback
The project provides a recapitulation of the three-spine stickleback methylation analysis in freshwater and marine groups (Artemov et al., 2017). Data was retrieved from the National Center for Biotechnology Information (NCBI) through the Sequence Read Archive (SRA). All sequences can be found under BioProject accession ID [PRJNA776820](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA776820).  
This project only considers groups from freshwater fish in freshwater (F@F) and marine fish in marine water (M@M). The sequences used are SRR16676624-SRR16676627 (F@F) and SRR16676637-SRR16676640 (M@M). 
## Usage
### Method 1
Run `main.sh`, providing the following parameters:  
**OPTIONS**  
- `-d`/`--dir`: directory on where the reads will be downloaded  
- `-r`/`--reads`: plaintext file in `.txt` on which reads will be downloaded. See `reads.txt` in the `01-get_reads` directory as an example.  
- `--fastp`/`--fastqc`: choose between Fastp or FastQC to use as a quality control tool  
- `--bis`/`--bsb`: choose between Bismark or BSBolt to use as a methylation analysis tool
### Method 2
If the reads retrieval or both reads retrieval and quality control steps have been finished in an earlier run, the `00-main.sh` scripts in `01-get_reads`, `02-quality_control`, or `03-methylation_analysis` may be executed instead.  
1. For `01-get_reads`, provide `-d`/`--dir` and `-r`/`--reads`.  
2. For `02-quality_control`, provide `-d`/`--dir`, `-r`/`--reads`, and `--fastp`/`--fastqc`.  
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


