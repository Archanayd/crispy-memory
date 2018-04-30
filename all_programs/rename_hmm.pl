#! usr/bin/perl -w
#input kix fasta file
open (FILE1, "hmm_res_in.txt") or die $!;
open(OP,">res");
  while ($line1 = <FILE1>)
    {
       chomp($line1);
     # if($line1 =~ />(.*)/)
      #if($line1 =~ />(.*)\s/)
if ($line1=~/>> /){ $line1=~ s/>>//;#print OP"$line1\n";
@a= split(/\|/,$line1); 
 
   
            $hash{"$id"} = $fasta;
		$id= $a[1];
           #$id = "$1";
print OP"$id\n";
           #print "$id\n";

           $fasta="";

}
        else{       
              $fasta .= $line1."\n";}#print $fasta;
        
}
$hash{"$id"} = $fasta;	

open (FILEW, ">hmm_alignment.txt") or die $!;
#system("awk '{print $2,$3"_"$4}' table_nonplant.txt >id.txt")
#a

open(FILE2,'ids_withspnames') or die $!;

foreach $line2(@b=<FILE2>){
chomp $line2;
#print $line2;
@char=split('\s',$line2);
$id1=$char[0];#print FILEW">$id1";
$species=$char[1];#print $species;





          if(exists ($hash{$id1})){
           $data=$hash{$id1};
              
#print "111\n";
         

print FILEW">> $id1|$species\n";
print FILEW"$data\n";}
}







