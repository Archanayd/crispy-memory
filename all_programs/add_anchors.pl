

open(F1,"y");
@f1= <F1>;
for ($i=0;$i<@f1;$i++){ 
chomp $f1[$i];
$file1= $f1[$i];
$f2= $file1;
$f2 =~ s/_fasta/_dom/g;
$file2= "tables/$f2";
open(IN,"$file1");
open(IN2,"$file2");
#open(OUT,"1_$file1");
open(OUT,">results/fasta/$file1");

while(<IN>){
#if(/^</){print OUT"$_"}

if(/^>(.*)/){$id=$1; 
#$id =~ tr/>//d;
chomp $id;
($acc,$sp)=split(/\|/,$id);
push (@a, $id);
print OUT"<a id=\"$acc\">>$id\n";

#foreach $b(@a){print $b;}
}
else{print OUT"$_";}

}


#open(OUT2,"2_$file1");
open(OUT2,">results/tables/$f2");
while (<IN2>){

if(/\|/){
foreach $b(@a){  ($acc2, $sp2)= split(/\|/, $b); #print $acc2;
if(/$acc2/){
$line=$_;
$line2= "<a href=\"../fasta/$sp2\_fasta.html#$acc2\" title=\"View this protein in FASTA format!\">$acc2|$sp2</a>";
$line=~s/$acc2\|$sp2/$line2/;
#print "$line\n";
print OUT2"$line";}}}
else{print OUT2"$_";}
}
}
