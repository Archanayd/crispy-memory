#please change the value in line 4 to remove last 'n' characters of substring from file name
open (F1, "$ARGV[0]");
$name1= "$ARGV[0]";
$name2 = (split(/\./,$name1))[0];
#$name =substr($name2, 0, -4);#kix
$name =substr($name2, 0, -6);#fasta and align
open (OP,">result/$name2.html");


if ($name2=~/align/){
$fasta= $name."_fasta.html"; $kix= $name."_kix.html";$dom= $name."_dom.html";


print OP"<html><body><font size=3 color=#006633>\n";
print OP"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
print OP"<tr align=\"right\" bgcolor=\"#E4F3F0\">\n";
print OP"<td height=\"25\"><font face=\"Verdana, Geneva, sans-serif\" size=\"2\" color=\"#0000FF\"> <a href=\"../../../table_fungi.html\">Back to table</a> |  <a href=\"../multifeature_plots/$name-plot.html\">View Multifeature Plots</a> | <a href=\"../domain_arrangements/$dom.html\">View Domain Arrangements</a> | <a href=\"../clustal/clustal_$name.html\">View Clustal Omega Alignment </a> | <a href=\"../fasta/$fasta\">Get FASTA</a> | <a href=\"../kix_seq/$kix\">Get KIX Region</a> | <a href=\"../sec_str/ss_$kix\">Get Secondary Structure</a>  </font></td></tr>\n";
print OP"</table>\n";
}

if ($name2=~/fasta/){
$align= $name."_align.html"; $kix= $name."_kix.html";$dom= $name."_dom.html";
print OP"<html><body><font size=3 color=#006633>\n";
print OP"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
print OP"<tr align=\"right\" bgcolor=\"#E4F3F0\">\n";
print OP"<td height=\"25\"><font face=\"Verdana, Geneva, sans-serif\" size=\"2\" color=\"#0000FF\"> <a href=\"../../../table_fungi.html\">Back to table</a> | <a href=\"../multifeature_plots/$name-plot.html\">View Multifeature Plots</a> | <a href=\"../domain_arrangements/$dom.html\">View Domain Arrangements</a> | <a href=\"../clustal/clustal_$name.html\">View Clustal Omega Alignment </a> | <a href=\"../alignments/$align\">Get Domain Alignment</a> | <a href=\"../kix_seq/$kix\">Get KIX Region</a> | <a href=\"../sec_str/ss_$kix\">Get Secondary Structure</a>  </font></td></tr>\n";
print OP"</table>\n";
}

if ($name2=~/kix/){
#print $name2;
$align= $name."_align.html"; $fasta= $name."_fasta.html"; $kix= $name."_kix.html";$dom= $name."_dom.html";
print OP"<html><body><font size=3 color=#006633>\n";
print OP"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
print OP"<tr align=\"right\" bgcolor=\"#E4F3F0\">\n";
print OP"<td height=\"25\"><font face=\"Verdana, Geneva, sans-serif\" size=\"2\" color=\"#0000FF\"> <a href=\"../../../table_fungi.html\">Back to table</a> | <a href=\"../multifeature_plots/$name-plot.html\">View Multifeature Plots</a> | <a href=\"../domain_arrangements/$dom.html\">View Domain Arrangements</a> | <a href=\"../clustal/clustal_$name.html\">View Clustal Omega Alignment </a> | <a href=\"../fasta/$fasta\">Get FASTA</a> | <a href=\"../alignments/$align\">Get Domain Alignment</a> | <a href=\"../sec_str/ss_$kix\">Get Secondary Structure</a>  </font></td></tr>\n";
print OP"</table>\n";
}
if ($name2=~/_dom/){
#print $name2;
$align= $name."_align.html"; $fasta= $name."_fasta.html"; $kix= $name."_kix.html";
print OP"<html><body><font size=3 color=#006633>\n";
print OP"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
print OP"<tr align=\"right\" bgcolor=\"#E4F3F0\">\n";
print OP"<td height=\"25\"><font face=\"Verdana, Geneva, sans-serif\" size=\"2\" color=\"#0000FF\"> <a href=\"../../../table_fungi.html\">Back to table</a> | <a href=\"../multifeature_plots/$name-plot.html\">View Multifeature Plots</a> | <a href=\"../clustal/clustal_$name.html\">View Clustal Omega Alignment </a> | <a href=\"../fasta/$fasta\">Get FASTA</a> |<a href=\"../kix_seq/$kix\">Get KIX Region</a>  | <a href=\"../alignments/$align\">Get Domain Alignment</a> | <a href=\"../sec_str/ss_$kix\">Get Secondary Structure</a>  </font></td></tr>\n";
print OP"</table>\n";
}
if ($name2=~/\-plot/){
#print $name2;
$align= $name."_align.html"; $fasta= $name."_fasta.html"; $kix= $name."_kix.html";
print OP"<html><body><font size=3 color=#006633>\n";
print OP"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
print OP"<tr align=\"right\" bgcolor=\"#E4F3F0\">\n";
print OP"<td height=\"25\"><font face=\"Verdana, Geneva, sans-serif\" size=\"2\" color=\"#0000FF\"> <a href=\"../../../table_fungi.html\">Back to table</a> | <a href=\"../domain_arrangements/$dom.html\">View Domain Arrangements</a> | <a href=\"../clustal/clustal_$name.html\">View Clustal Omega Alignment </a> | <a href=\"../fasta/$fasta\">Get FASTA</a> |<a href=\"../kix_seq/$kix\">Get KIX Region</a>  | <a href=\"../alignments/$align\">Get Domain Alignment</a> | <a href=\"../sec_str/ss_$kix\">Get Secondary Structure</a>  </font></td></tr>\n";
print OP"</table>\n";
}

while (<F1>){print OP"$_";}


