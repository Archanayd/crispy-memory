open(IN,"x");
@files1=<IN>;
close(IN);



for($ifile=0;$ifile<@files1;$ifile++)
{
@loc=();
chomp $files1[$ifile];

$name = (split(/-fa.html/,$files1[$ifile]))[0];
#print "$files1[$ifile]--- $name\n";
open (FILE1, "$files1[$ifile]") or die $!;

$i=0;

while(<FILE1>)
				{
				if(/$name/){ #print $name;
				$fn=$name;
				
				open (OUT,">>$fn\_fasta.html");
				if ($i==0){
				print OUT"<html><body><font size=3 color=#006633><pre>\n";$i++}
				print OUT"$_"; 
				$_=<FILE1>; print OUT"$_";}
				
				}
			}	

