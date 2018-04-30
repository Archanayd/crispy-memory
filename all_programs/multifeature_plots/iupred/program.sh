#!/bin/bash

for i in kix_seqs/*.html
do
var1=$(echo $i | awk -F"_kix.html" '{print $1,$2}')
set -- $var1
echo $1
echo $1> filename.txt
var2=$(cut -d "/" -f2 filename.txt)

#cp $i /Archana_work/domains_architecture/KIX_update_21-1-17/metazoa_update/multifeature_plots/KIX_res.txt 
cp $i KIX_res.txt 


perl -e 'open(F1, "KIX_res.txt");$i=1;while(<F1>){ if (/^</){next;}if(/^>(.*)/){$id= $1; push (@id, "$1");next;}elsif(/[A-Z]/) {$seq = $_; if($seq =~ m/X|B|Z|O|J|U/ig){print " error"; open(OPERR,">ERRORSEQ");}open(OP,">iupred/in_$i.fa");print OP">$id\n";print OP"$seq";$i++;}}'


for j in iupred/*.fa
do
var3=$(echo $j | awk -F"." '{print $1,$2}')
set -- $var3
#echo $1 > filename.txt
#var2=$(cut -d "/" -f7 filename.txt)
       # echo "processing $j file..."
       # echo "running psipred..."
	echo len$j
		#iupred/psipred/BLAST+/runpsipredplus $j
		/Archana_work/softwares/psipred/BLAST+/runpsipredplus $j
		cp *.ss2 iupred/
        	sed -e'1,2d' $1'.ss2' > $1'sec_str.ss2'
	# echo "running iupred..."
        iupred/iupred $j long > iupred/disorder_output
        sed '/\#/d' iupred/disorder_output>$1'_dis.txt'

done

python iupred/graph_copy2.py
for k in *.png
do
echo "<p align=\"center\"><img src=\"../../../pngs/pngs_plants/\"$k\" width=\"600\" height=\"500\"></p></ol>" >>addpnglines.txt

done

sed '/<ol>/r addpnglines.txt' plot1.txt >$var2-plot.html

cp *.html plots_htmls/
cp *.png graph_pngs
rm -rf in_* *.png *.html addpnglines.txt iupred/in_* 

done



