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
  
#	sed -i -e 's/,221294104,/,896450220,/g' Verify71/$filename
#	sed -i -e 's/,953630446,/,845150171,/g' Verify71/$filename
#	sed -i -e 's/,713750123,/,41648507,/g' Verify71/$filename
#	sed -i -e 's/,338402032,/,308557629,/g' Verify71/$filename
#	sed -i -e 's/,450644373,/,212963282,/g' Verify71/$filename
#	sed -i -e 's/,41759669,/,163631617,/g' Verify71/$filename
#	sed -i -e 's/,736315070,/,183986902,/g' Verify71/$filename
#	sed -i -e 's/,604280769,/,158500313,/g' Verify71/$filename
#	sed -i -e 's/,748327135,/,41648507,/g' Verify71/$filename
#	sed -i -e 's/,894368409,/,17,/g' Verify71/$filename
#	sed -i -e 's/,187017321,/,129863917,/g' Verify71/$filename
	
	

	sed -i -e 's/0,SNPUPDT/,SNPUPDT/g' Verify71/sqlload_AGENTLINE.txt	
echo "5"
	sed -i -e 's/"//g' 62_formatted_files/sqlload_AGENTLINE.txt




	diff -y 62_formatted_files/$filename Verify71/$filename > $filename"_diff"

	grep " |" $filename"_diff" > Difference/$filename"_modified_diff"

	#cut -d "|" -f 1 $filename"_modified_diff" > Difference/62_$filename 
	#cut -d "|" -f 2 $filename"_modified_diff" > Difference/71_$filename 

	grep ">" $filename"_diff" > Difference/new_$filename
	 
	#rm  $filename"_diff"
	#rm  $filename"_modified_diff" 

done <list_tables




mv sqlload_*.txt_diff Difference/

#rm *_diff	 2>/dev/null



