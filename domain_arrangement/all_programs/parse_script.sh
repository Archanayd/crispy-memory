#script to filter domtblout output

for i in domtblout/*.domtblout
do
#fname=`echo $i|awk -F"\/" '{print $2}'|awk -F"." '{print $1}'`;

python parse_domtblout.py --file $i 

done
