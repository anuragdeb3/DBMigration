while read filename
do
	echo "trimming $filename" >> verify_vn.log
	tail -n +10 sql_export62/$filename > 62_formatted_files/$filename
	
	#sed -i -e 's/SNPUPDT//g' 62_formatted_files/$filename
	#sed -i -e 's/"//g' 62_formatted_files/$filename
echo "1"
	sed -i -e 's/,"/,/g' 62_formatted_files/$filename
echo "2"
	sed -i -e 's/",/,/g' 62_formatted_files/$filename
echo "3"
	sed -i -e 's/DYNUPDT "SYSDATE"/DYNUPDT SYSDATE/g' 62_formatted_files/$filename
echo "4"
  
echo "5"
	sed -i -e 's/"//g' 62_formatted_files/sqlload_AGENTLINE.txt




	diff -y 62_formatted_files/$filename Verify71/$filename > $filename"_diff"

	grep " |" $filename"_diff" > Difference/$filename"_modified_diff"

	#cut -d "|" -f 1 $filename"_modified_diff" > Difference/62_$filename 
	#cut -d "|" -f 2 $filename"_modified_diff" > Difference/71_$filename 

	grep ">" $filename"_diff" > Difference/new_$filename
	 
	#rm  $filename"_diff"
	#rm  $filename"_modified_diff" 

done <list_tables1




mv sqlload_*.txt_diff Difference/

#rm *_diff	 2>/dev/null



