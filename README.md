# DBMigration

Need : The Project needs migration of data between two platforms. Say previous platform version was 6.2 and new one is 7.1.
       SQLLoader was used for exporting the data on 6.2 platform.
       Then dump was imported to New Platform 7.1.
       This Script(V 0.1) includes extracting data from New Platform 7.1 and compare SQL Loader file that we got during Export from 6.2.
       V 0.2 contains comparing DBs of both platform.

Version : 0.1      

Language Used : This Script(V 0.1) uses combination of perl python and shell to Compare DBs.
                Perl to extract data from DB.
                Python to format the data.
                

extract.pl              : Extracts from New Platform.
Verify.sh               : Manages all the scripts.
sql_export62            : Contains all the SQL Loader data from old Platform
Verify71                : Contains all the extracted data from new Platform
62_formatted_files      : After formatting SQL Loader files are stored here.
sql_file_generator.py   : It makes list_table & sql_common.cmd in sync.
format_71_data.py       : Formats the 6.2 SQL Loader files
difference.sh           : Comparision is done through this script.
list_tables             : Contains all the names of SQL Loader files that needs to be extracted. 
AllSql.cmd              : Contains all the sql queries
sql_common.cmd          : Contains all the sql queries
verify_vn.log           : All outputs are logged in this file.
Difference              : Contains all the differences in below formats :
                            sqlload_<TABLE_NAME>.txt_diff           : contains all the differences tabular wise
                            sqlload_<TABLE_NAME>.txt_modified_diff  : contains rows that got modified
                            new_sqlload_<TABLE_NAME>.txt            : contains rows that are missing/added
                
