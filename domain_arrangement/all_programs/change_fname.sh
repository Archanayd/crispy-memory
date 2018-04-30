#script to delete tags in fasta "*.html" files to fasta_without_tags for hmmscan


for i in filtered/*.out
do
#echo $i
fname=`echo $i|awk -F"/" '{print $2}'|awk -F".domtblout.out" '{print $1}'`;

mv $i filtered/$fname.gtf 

done

