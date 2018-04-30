open (OP2,">loc");
open(IN,"x");
@files1=<IN>;
close(IN);
#open (FILE1, "result_profile_60+.txt") or die $!;

open(IN,"y");
@files2=<IN>;
close(IN);


for($ifile=0;$ifile<@files1;$ifile++)
{
@loc=();
chomp $files1[$ifile];
chomp $files2[$ifile];
$name = $files2[$ifile];
#$name = (split(/_/,$files2[$ifile]))[0];
#print "$files1[$ifile]-- $files2[$ifile] -- $name\n";


open (FILE1, "$files1[$ifile]") or die $!;
#open (FILE1, "result_profile_60+.txt") or die $!;
open (FILE2, "$files2[$ifile]") or die $!;


@a=();
$id ="";
@loc= ();
foreach $line(@a=<FILE1>){


if($line=~ /^>>\s+(.*)/)
{
chomp$line;
$id= $1;}
#print "$id\n";
#   1 !  107.5   0.1   1.9e-34   4.3e-31       2      76 .]       6      80 ..       5      80 .. 0.98
#@cellMessage = split /\s{2,}/, $message;


if($line =~ /!/)
{

@c= split /\s+/,$line;

$score= $c[2];
$evalue1 = $c[4];
$evalue2 = $c[5];
$from = $c[13]; #envfrom
$to= $c[14]; #envto

$id =~ s/\s+//; #remove white space

$location= "$id\t$from\t$to\n";

push(@loc, "$location");

}
}
print OP2"@loc";
open (FILEW, ">$name\-ki.html") or die $!;
print FILEW"<html><body><font size=3 color=#006633><pre>\n";        


undef %hash; #empty hash
while ($line1 = <FILE2>)
{
$id="";$seq1="";
       $line1 =~ s/\s+|\t//; #remove white space  
      if($line1 =~ />(.*)/)
     {
            $hash{"$id1"} = $fasta;
           $id1 = "$1";
           print OP3"$id1\n";
           $fasta="";

}
        else{       
              $fasta .= $line1;}
        
       
}
$hash{"$id1"} = $fasta;	
	
		#print OP3"@loc";

foreach $line2(@loc){
#print $line2;

chomp$line2;
@char=split('\t',$line2);

$id2=$char[0];
$start=$char[1];
$end=$char[2];
#print $id1;

          
          if(exists ($hash{$id2})){
           $data=$hash{$id2};
              #print "$id1\t$start\t$end\n";
    $len=$end-$start;
          #print "$len\n";
if($len>=64){ #because starting amino acid is also included
           $seq1=substr($data,$start-1,$len+1);
        


print FILEW">$id2|$start-$end\n";
print FILEW"$seq1\n";
}
$id2="";$seq1="";
}}}
