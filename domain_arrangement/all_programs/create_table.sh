for i in gtfs/*.gtf
do
#fname=`echo $i|awk -F"\/" '{print $2}'|awk -F"." '{print $1}'`;
fname=`echo $i|awk -F"\/" '{print $2}'|awk -F".gtf" '{print $1}'`;
fname2=$fname"_dom";

echo "<!DOCTYPE html>
<html>
<head>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
</head>
<body>
<script type="text/javascript">
<!--

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
<br>
<br>
 <td><a href=\"graphs/$fname.pdf\" onclick=\"MM_openBrWindow('graphs/$fname.pdf','pdf','scrollbars=yes,width=650,height=500'); return false;\"><b>CLICK TO VIEW DOMAIN ARRANGEMENT GRAPHS!</b></a></td>
<br>
<br>
<table>
<tr>
<th>Query</th>
    <th>Domain name</th>
    <th>Domain ID</th>
    <th>Position from</th>
    <th>Position to</th>
    <th>Seq length</th>
  </tr>
  <tr>" >tables/$fname2.html
  
  
while read col1 col2 col3 col4 col5 col6
do

echo "<td>$col1</td>
    <td>$col2</td>
    <td>$col3</td>
    <td>$col4</td>
    <td>$col5</td>
    <td>1$col6</td>

  </tr>
  <tr>"

done <$i >>tables/$fname2.html
done
