open (F1, "$ARGV[0]");
$name1= "$ARGV[0]";
$name2 = (split(/\.html/,$name1))[0];

open (OP,">result/$name2.html");

if ($name1=~/ss/){

$name3 =substr($name2, 3); #for ss
#$name =substr($name3, 0, -4); #for ss
$name =substr($name2, 8); #for clustal file

$align= $name."_align.html"; $fasta= $name."_fasta.html";$kix= $name."_kix.html";
print OP"<html><body><font size=3 color=#006633>\n";
print OP"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
print OP"<tr align=\"right\" bgcolor=\"#E4F3F0\">\n";
print OP"<td height=\"25\"><font face=\"Verdana, Geneva, sans-serif\" size=\"2\" color=\"#0000FF\"> <a href=\"../../../table_metazoa.html\">Back</a> | <a href=\"../plots/$name-plot.html\">Get Multifeature Plots</a> | <a href=\"../clustal/clustal_$name.html\">Get Clustal Omega Alignment </a> | <a href=\"../alignments/$align\">Get Domain Alignment</a> | <a href=\"../kix_seq/$kix\">Get KIX Region</a> | <a href=\"../fasta/$fasta\">Get FASTA</a>  </font></td></tr>\n";
print OP"</table>\n";
}

if ($name1=~/clustal/){
$name =substr($name2, 8); #for clustal file

$align= $name."_align.html"; $fasta= $name."_fasta.html";$kix= $name."_kix.html";
print OP"<html><body><font size=3 color=#006633>\n";
print OP"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
print OP"<tr align=\"right\" bgcolor=\"#E4F3F0\">\n";
print OP"<td height=\"25\"><font face=\"Verdana, Geneva, sans-serif\" size=\"2\" color=\"#0000FF\"> <a href=\"../../../table_metazoa.html\">Back</a> | <a href=\"../plots/$name-plot.html\">Get Multifeature Plots</a> | <a href=\"../alignments/$align\">Get Domain Alignment</a> | <a href=\"../kix_seq/$kix\">Get KIX Region</a> | <a href=\"../fasta/$fasta\">Get FASTA</a> | <a href=\"../sec_str/ss_$kix\">Get Secondary Structure</a> </a> </font></td></tr>\n";
print OP"</table>\n";
}
while (<F1>){print OP"$_";}



