open (F1, "fasta_species.txt") or die $!;
$i=0;

			while(<F1>)
				{
				if(/>(.*)\|(.*)/){ #print $2;
				$fn= $2;
				open (OUT,">>$fn");

				print OUT"$_"; $flag=1;$_=<F1>;}
				if ($flag==1){print OUT"$_";}
				}
			close(F1);

