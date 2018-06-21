#!/usr/bin/perl

no warnings;

open(SQL_CMD, "<sql_common.cmd") || die "unable to open file\n";

while(<SQL_CMD>){
  #print "$_";
    my $ip = $_;
    my @t = split(/\|/, $ip);
    print $t[1];
    my $logfile = "1.sql";
    open(INFO_LOG, ">", "$logfile")|| die "Cannot open file $logfile!\n";
    print  INFO_LOG "set pages 0\n";
    print  INFO_LOG "set feedback off\n";
    print  INFO_LOG "set heading on\n";
    print  INFO_LOG "set linesize 5000\n";
    print  INFO_LOG "set termout on\n";
    print  INFO_LOG "set trimspool on\n";
    print  INFO_LOG "spool 1.lst\n";
    print  INFO_LOG "$t[1]\n";
          
    print  INFO_LOG "spool off\n";
    print  INFO_LOG "exit\n";
    close(INFO_LOG);

`ORACLE_SID=PSMF; export ORACLE_SID;`;

my $ORA_LGN=`.oralgn $ARGV[0] PSMF`;

chomp($ORA_LGN);

my $tree_ri = `sqlplus $ORA_LGN > 1.log <<END
        \@1.sql
        END`;

	
	#ecncore71/e00273ed0cd86@psmf.world
	#ecnvn71/e71cf67c0ac93@psmf.world
	#my $tree_ri = `sqlplus ecnvn71/e71cf67c0ac93\@psmf.world > 1.log <<END
       # \@1.sql
       #END`;
    
    my $nc_get = '1.lst';         
          open(ECNINFO, $nc_get)|| die "Cannot open ECN file!\n";              
          my @nc_getlines = <ECNINFO>;                
          close(ECNINFO);
		  
		  
    my $logfile1 = "$t[0].txt";
       open(INFO_LOG, ">$logfile1")|| die "Cannot open file tocfile!\n";

     	my  $count1=0; 
          foreach  my $morsel1 (@nc_getlines) 
		{
            		if($morsel1 ne "\n")
              	    {
			          my $count1=1;
			          chop($morsel1);
				#print $morsel1;
			         # $morsel1=~ tr/ //s;
			          print INFO_LOG "$morsel1\n";
                  	    }
              }
   
      close(INFO_LOG);
          
}

