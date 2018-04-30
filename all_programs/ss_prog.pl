
open (F1, "$ARGV[0]");
$name1= "$ARGV[0]";
$name = (split(/\.html/,$name1))[0];
print $name;
system("rm sec_str/*.fa sec_str/*.fasta sec_str/*.horiz sec_str/*.blast");
system ("rm *.ss *.ss2 *.horiz *.fasta *.mtx *.blast *.mtx");
$i=1;
while(<F1>){ if (/^</){next;}
if(/^>(.*)/){$id= $1; push (@id, "$1");next;}
elsif(/[A-Z]/) {$seq = $_; #print "$seq\n"; 

open(OP,">sec_str/in_$i.fa");
print OP"$seq";
system("/Archana_work/softwares/psipred/BLAST+/./runpsipredplus sec_str/in_$i.fa");


open (F2, "in_$i.horiz");

while (<F2>){push(@file,"$_");}
open (OP2, ">sec_str/in2_$i.horiz"); #print $id;
#print OP2"<pre>\n";
print OP2"<u>Secondary Structure for "."$id"." :<\/u>\n\n"; 

#print OP2"<span style=\"background:pink;\">Secondary Structure for "."$id"." :<\/span>\n\n"; 

print OP2"@file";
@file=();
$i++;
}
}
#system(q(cat $(find ./ -name "in2_*.horiz" | sort -V)>sec_str/sec_str.html));
system("cat sec_str/in2_*.horiz > sec_str/sec_str.html"); 
#system ("(echo -n '<pre> '; cat sec_str/sec_str.html) >sec_str/sec_str2.html");

open(F1,"sec_str/sec_str.html");
open(OP3,">sec_str/ss_$name.html");

print OP3"<pre>";
while (<F1>){
if (/Pred:/){ $_=~ s/(C+)/<font color=#FFD700>$1<\/font>/g;}
if (/Pred:/){ $_=~ s/(H+)/<font color=#FF3366>$1<\/font>/g;}
if (/Pred:/){ $_=~ s/(E+)/<font color=#8CCF26>$1<\/font>/g;}

 print OP3"$_";
}

