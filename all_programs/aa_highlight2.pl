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
$name = (split(/\./,$files2[$ifile]))[0];
print "$files1[$ifile]-- $files2[$ifile] -- $name--\n";


open (FILE1, "$files1[$ifile]") or die $!;
open (FILE2, "$files2[$ifile]") or die $!;

foreach $line(@a=<FILE1>){
if($line=~ /^>>\s+(.*)/)
{
chomp$line;
$id= $1;}
##   1 !  107.5   0.1   1.9e-34   4.3e-31       2      76 .]       6      80 ..       5      80 .. 0.98
##@cellMessage = split /\s{2,}/, $message;
        if($line =~ /!/)
        {
                @c= split /\s{2,}/,$line;
                $score= $c[2];
                $evalue1 = $c[4];
                $evalue2 = $c[5];
                $from = $c[10];
                $to= $c[11];
                $id =~ s/\s+//; #remove white space
                chop$to;
                chop$to;
                chop$to;
                chop$to;
                chop$to;
                chop$to;
                chop$to;
                chop$to;
                chop$to;
                if($to-$from>=64){
                $location= "$id\t$from\t$to\n";
                push(@loc, "$location");}
        }
}
#open (OP1, ">KIX_res.txt") or die $!;
#print OP1"<html><body><font size=3 color=#006633><pre>\n";
open (OP2, ">$name-fa.html") or die $!;
print OP2"<html><body><font size=3 color=#006633><pre>\n";
while ($line1 = <FILE2>)
{
        chomp;
       $line1 =~ s/\s+|\t//; #remove white space  
      if($line1 =~ />(.*)/)
     {
           $id1 = "$1";
           #print OP3"$id1\n";
           $fasta="";
      }
      
        else{ $len_line= length$line1; push (@len1,$len_line);
		$hash{$id1} .= $line1."<br>";
        }
}$length= $len1[1];
$domain_count=1;
#print "\n\n$loc[1]\n\n";
foreach $line2(@loc){
	chomp$line2;
	#print $line2;
	@char=split('\t',$line2);
	$id1=$char[0];
	$start=$char[1];
	$end=$char[2];
	if($previous_id ne $id1)
	{
		$domain_count=1;
		print OP2">$previous_id\n";
		print OP2"$data\n";
	        if(exists ($hash{$id1})){
	        $data=$hash{$id1};}
	}
	$len=$end-$start;
	if($len>=64){ #because starting amino acid is also included
        $seq1=substr($data,$start-1,$len+1);
	$uniq= "$id1\n";
	print OP1">$id1|$start-$end\n";
	print OP1"$seq1\n";
	substr($data,0,&number($end,$domain_count)) .= "</span>";
	substr($data,0,&number($start-1,$domain_count)) .="<span style='background-color: #F5A2A3'>";
	push(@loc2, "$uniq");
	}
$previous_id=$id1;
$domain_count++;
}
print OP2">$previous_id\n";
print OP2"$data\n";
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

my @loc3 = uniq(@loc2);
foreach$uniqid(@loc3){
#Sprint OP2"$uniqid\n";
 }
  @loc3=();@loc2=();@loc=();

sub number
{#print @_;
my ($number,$count)=@_;

my $result=$number+int($number/$length)*4+($count-1)*47;#print "$result\n";
return $result; 
}
}
                         
