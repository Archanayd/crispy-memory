for i in fungi/fasta_without_tags/*.fa
do
fname=`echo $i|awk -F"\/" '{print $3}'|awk -F"." '{print $1}'`;

#hmmer-3.1/binaries/hmmscan 3_Pfam-A_profile.hmm $i > hmmscan_output/$fname.txt
#hmmer-3.1/binaries/hmmscan --domtblout fungi/domtblout/$fname.domtblout 3_Pfam-A_profile.hmm $i
hmmer-3.1/binaries/hmmsearch --domtblout fungi/domtblout/$fname.domtblout 3_Pfam-A_profile.hmm $i


done

#gsed -i '/KIX domain/d' fungi/domtblout/*.domtblout 
