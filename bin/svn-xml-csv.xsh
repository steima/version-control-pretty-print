# Test XMLSH script

xread xmlfile < tmp.xml

echo $xmlfile | xml2csv > tmp.csv
