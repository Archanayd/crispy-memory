#open (F1, "KIX_res.txt") or die $!;
open (F1, "$ARGV[0]");
$name1= "$ARGV[0]";
$name2 = (split(/\.html/,$name1))[0];
$name =substr($name2, 0, -4);

open (F2, "fasta_set") or die $!;
open (OP2, ">clustal_raw.html") or die $!;
system ("rm *.aln");
system ("rm *.dnd");
system ("rm *.txt");
while(<F2>){$f2.=$_;}
#print $f2;
$i=1; 

			while(<F1>)
				{
				if(/^>(.*)/){ $fn= "$_"; push (@id, "$1");

				 $flag=1;$_=<F1>;}
				if ($flag==1){$ff= $fn.$_;
				$f3= $f2.$ff;
				open (OP, ">out_$i.txt") or die $!;
				print OP"$f3";
				system ("./clustalo -i out_$i.txt --outfmt clu > out_$i.aln");

				system ("cat *.aln> clustal_res.aln");		
					$i++;	}
				}
			close(F1);

#print @id;
open (F3,"clustal_res.aln");
print OP2"<pre>\n";
while(<F3>)
{$aln= $_; 
$aln=~ s/CLUSTAL 2.1 multiple sequence alignment/<u>CLUSTAL 2.1 multiple sequence alignment<\/u>/;
foreach $ide(@id){ $ide =~ s/:/_/; $id = substr ($ide, 0,30);#print "$id\n";
$aln=~ s/\Q$id\E/<span style=\"background:#FFFF99;\">$id<\/span>/;  
}print OP2"$aln";}

system("sed 's/<span style=\"background:#FFFF99;\"><span style=\"background:#FFFF99;\">/<span style=\"background:#FFFF99;\">/g' clustal_raw.html >clustal/clustal_$name.html");
