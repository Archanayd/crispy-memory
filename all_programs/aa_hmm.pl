#open(F1, "result.txt");
#open(F1, "result.txt"); 
open (F1, "$ARGV[0]");
$name1= "$ARGV[0]";
$name = (split(/\.html/,$name1))[0];
#$name =substr($name2, 0, -4);

open(OP, ">align/$name.html");


print OP"<pre>\n";

while (<F1>){ 

if (/^>>/){$header= $_;$i=0; $_=<F1>;@b=();
@data=();
$j=0;
}
#
if(/!/){ 
@b= split(/\s+/,$_);  if (($b[14]-$b[13])>=64){ #print "$b[14] and $b[13]\n"; 
push(@data,$b[1]." ".$b[7]." ".$b[8]." ".$b[10]." ".$b[11]."\n");
$j++;
#push (@data,$_); print "@data\n";

if ($j<2){print OP"\n<span style=\"background:#CCF2FF;\">$header<\/span>";}


}}


if (/== domain/ )
{
foreach $par(@data){ $c= substr($par,0,1);

if(substr($_,12,1) == $c){

#print $_;
($no,$start1,$end1,$start2,$end2)=split(/\s+/,$data[$i]);
							
							do {# print $header;
							 if(!/\d+\*/) { print OP"$_"; 
								}
							 ($no1,$start3,$end3,$start4,$end4)=split(/\s+/,$_);
										
							 }
						while ( $_=<F1> and $end1 != $end3 and $end2!=$end4); 
								$i++; 
								 } 
                                                   else { $flag2=0; }
                                                      }
}}




