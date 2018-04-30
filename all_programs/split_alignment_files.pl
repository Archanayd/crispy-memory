open (F1, "hmm_alignment.txt") or die $!;

$i=0;

			while(<F1>)
				{
				if(/>> (.*)\|(.*)/){ $fn= $2;$fn; #print $fn;
				open (OUT,">>$fn\_align.html");
				print OUT"<html><body><font size=3 color=#006633><pre>\n";
				print OUT"<pre>\n\n";
				print OUT"$_"; $flag=1;$_=<F1>;}
				if ($flag==1){print OUT"$_";}
				}
			close(F1);

