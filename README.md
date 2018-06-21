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
                
