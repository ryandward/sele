Setup for Sele Quick-Query TSV Tool
#######################################

The motivation for this small walkthrough and tool is if you have to look through a lot of files and retrieve information about one field based on another field. You're sick of importing everything into a SQL database, even SQLite is getting messy because of these one-off files you never need to see again.


Softlink sele to somewhere in your path. I use Arch Linux and recommend:

::

  $ ln -s sele /usr/local/bin/
  

Adjust ``column`` and ``awk`` such that the expected field separator is the tab.

::

  $ alias='column -ts $'\''\t'\'
  $ alias='awk -vFS='\''\t'\'' -vOFS='\''\t'\'

I highly recommend putting this in your ``~/.bashrc`` or ``~/.zshrc`` file.

Grab this Perl module to convert csv to tsv.

::

  $ cpan cpanminus
  $ cpanm install Text::CSV


I also highly recommend turning everything into a tsv instead of csv, because all bioinformatics uses tsv it's almost a waste of time to code csv tools.

Keep this Perl oneliner handy to turn your csv into tsv.

::

  $ perl -MText::CSV -lne 'BEGIN { $csv = Text::CSV->new() } print join "\t", $csv->fields() if $csv->parse($_)' infile.csv > outfile.tsv 
  
::

How to use
##########

Let's say you wind up with a big tsv, and you need only a few rows from it, ``ctrl+F`` in Excel is an option, but it's messy.

We could also throw the file into a realational database management system, but that's tricky. It's also tedious because you probably never need to see this file agan.

::

  $ head example.tsv | column
  
  Run         Assay_Type  AvgSpotLen  Bank  Bases      BioProject   BioSample     BioSampleModel                   Bytes      Center_Name                          Collection_Date  Consent  DATASTORE_filetype  DATASTORE_provider  DATASTORE_region                Drug_concentration_ug/ml  Experiment  Generations            Genotype  geo_loc_name_country  geo_loc_name_country_continent  geo_loc_name  Host            Instrument           Library_Name                LibraryLayout  LibrarySelection  LibrarySource  Organism                 Platform  ReleaseDate           Sample_Name                 Sample_Type    SRA_Study  Strain      TEST    Time  TREATMENT
  SRR7686615  Tn-Seq      51          G9    538978710  PRJNA485590  SAMN09810092  Microbe,_viral_or_environmental  248363157  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  0                         SRX4547300  0_generations_broth    gyrA      USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_0_CIP_BG9_T1_1         SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_0_CIP_BG9_T1_1         Broth_Culture  SRP157243  ATCC_17978  TEST-1  T1    CIP
  SRR7686616  Tn-Seq      51          G9    408663867  PRJNA485590  SAMN09810093  Microbe,_viral_or_environmental  192944040  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  1.1                       SRX4547299  7-8_generations_broth  gyrA      USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_1_1_CIP_BG9_T2_1       SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_1_1_CIP_BG9_T2_1       Broth_Culture  SRP157243  ATCC_17978  TEST-1  T2    CIP
  SRR7686617  Tn-Seq      51          G9    412526760  PRJNA485590  SAMN09810094  Microbe,_viral_or_environmental  194374049  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  0                         SRX4547298  7-8_generations_broth  gyrA      USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_0_CIP_BG9_T2_1         SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_0_CIP_BG9_T2_1         Broth_Culture  SRP157243  ATCC_17978  TEST-1  T2    CIP
  SRR7686618  Tn-Seq      51          GP1   527734791  PRJNA485590  SAMN09810095  Microbe,_viral_or_environmental  268238969  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  0                         SRX4547297  0_generations_broth    gyrAparC  USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_PARC_0_CIP_BGP1_T1_1   SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_PARC_0_CIP_BGP1_T1_1   Broth_Culture  SRP157243  ATCC_17978  TEST-1  T1    CIP
  SRR7686619  Tn-Seq      51          G7    355808283  PRJNA485590  SAMN09810088  Microbe,_viral_or_environmental  167670188  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  0                         SRX4547296  7-8_generations_broth  gyrA      USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_0_CIP_BG7_T2_1         SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_0_CIP_BG7_T2_1         Broth_Culture  SRP157243  ATCC_17978  TEST-1  T2    CIP
  SRR7686620  Tn-Seq      51          G8    665414289  PRJNA485590  SAMN09810089  Microbe,_viral_or_environmental  314279006  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  0                         SRX4547295  0_generations_broth    gyrA      USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_0_CIP_BG8_T1_1         SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_0_CIP_BG8_T1_1         Broth_Culture  SRP157243  ATCC_17978  TEST-1  T1    CIP
  SRR7686621  Tn-Seq      51          G8    456401856  PRJNA485590  SAMN09810090  Microbe,_viral_or_environmental  213181290  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  1.1                       SRX4547294  7-8_generations_broth  gyrA      USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_1_1_CIP_BG8_T2_1       SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_1_1_CIP_BG8_T2_1       Broth_Culture  SRP157243  ATCC_17978  TEST-1  T2    CIP
  SRR7686622  Tn-Seq      51          G8    459236691  PRJNA485590  SAMN09810091  Microbe,_viral_or_environmental  215107038  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  0                         SRX4547293  7-8_generations_broth  gyrA      USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_0_CIP_BG8_T2_1         SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_0_CIP_BG8_T2_1         Broth_Culture  SRP157243  ATCC_17978  TEST-1  T2    CIP
  SRR7686623  Tn-Seq      51          GP1   604205262  PRJNA485590  SAMN09810096  Microbe,_viral_or_environmental  305193941  TUFTS_UNIVERSITY_SCHOOL_OF_MEDICINE  2018             public   fastq,sra           gs,ncbi,s3          gs.US,ncbi.public,s3.us-east-1  13-14                     SRX4547292  7-8_generations_broth  gyrAparC  USA                   North_America                   USA:Boston    Not_Applicable  Illumina_HiSeq_2500  GYRA_PARC_13_CIP_BGP1_T2_1  SINGLE         PCR               METAGENOMIC    Acinetobacter_baumannii  ILLUMINA  2018-08-11T00:00:00Z  GYRA_PARC_13_CIP_BGP1_T2_1  Broth_Culture  SRP157243  ATCC_17978  TEST-1  T2    CIP


Let's look at a way to narrow in on what we want by specifying particular columns by adding the ``-c`` switch (*i.e.* column) and specifying the column names, separated by a comma.

::

  $ sele -c Run,BioSample,Treatment,Time,Organism,Bank,Platform,Drug_concentration_ug/ml | head | column
  
  RUN         BIOSAMPLE     TREATMENT  TIME  ORGANISM                 BANK  PLATFORM  DRUG_CONCENTRATION_UG/ML
  SRR7686615  SAMN09810092  CIP        T1    Acinetobacter_baumannii  G9    ILLUMINA  0
  SRR7686616  SAMN09810093  CIP        T2    Acinetobacter_baumannii  G9    ILLUMINA  1.1
  SRR7686617  SAMN09810094  CIP        T2    Acinetobacter_baumannii  G9    ILLUMINA  0
  SRR7686618  SAMN09810095  CIP        T1    Acinetobacter_baumannii  GP1   ILLUMINA  0
  SRR7686619  SAMN09810088  CIP        T2    Acinetobacter_baumannii  G7    ILLUMINA  0
  SRR7686620  SAMN09810089  CIP        T1    Acinetobacter_baumannii  G8    ILLUMINA  0
  SRR7686621  SAMN09810090  CIP        T2    Acinetobacter_baumannii  G8    ILLUMINA  1.1
  SRR7686622  SAMN09810091  CIP        T2    Acinetobacter_baumannii  G8    ILLUMINA  0
  SRR7686623  SAMN09810096  CIP        T2    Acinetobacter_baumannii  GP1   ILLUMINA  13-14

Cool, now we can see what the file looks like. We might want to narrow it down though. Let's use the ``-w`` switch (*i.e.* where). Be safe and wrap the entire ``-w`` operand in single quotes -- this is an absolute must for mathmetical relationships, since ``>`` means something else to a command-line interpreter.

::

  $ sele -c Run,BioSample,Treatment,Time,Organism,Bank,Platform,Drug_concentration_ug/ml -w 'DRUG_CONCENTRATION_UG/ML>1,BANK==GP3' example.tsv
  
  RUN         BIOSAMPLE     TREATMENT  TIME  ORGANISM                 BANK  PLATFORM  DRUG_CONCENTRATION_UG/ML
  SRR7686662  SAMN09810102  CIP        T2    Acinetobacter_baumannii  GP3   ILLUMINA  13-14
  
Let's pipe this ``RUN`` number into something downstream by passing the ``-q`` switch (*i.e.* quiet), which suppresses the header.

::
  
  $ sele -q -c Run -w 'DRUG_CONCENTRATION_UG/ML>1,BANK==GP3' example.tsv
  SRR7686662
  
  $ sele -q -c Run -w 'DRUG_CONCENTRATION_UG/ML>1,BANK==GP3' example.tsv | downstream.script
  Some downstream script says "Thank you for feeding me SRR7686662".
  


Valid options for the ``where`` clause are:


+--------+-----------------+
| Symbol | Meaning         |
+========+=================+
| ==     | Equals          |
+--------+-----------------+
| !=     | Not Equals      |
+--------+-----------------+
| ~      | Regex           |
+--------+-----------------+
| !~     | No Regex        |
+--------+-----------------+
| >,>=,< | Math operations |
+--------+-----------------+

Note: Math operations **strongly** type the operand -- *e.g.* ``dose>13-14`` will be interpreted as ``dose>13``, and ``length>six`` will be interpreted as ``length>0`` .


Ryan Ward

https://orcid.org/0000-0001-9537-2461
