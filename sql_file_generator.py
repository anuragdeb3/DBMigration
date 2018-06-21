import os

def fileList():
	tables = ''
        table_name = ''
        file_list = []
	os.system("mv sql_export62/sqlload_CALEND16.txt sql_export62/sqlload_CALEND16.txt_bakk")
	os.system("ls sql_export62/sqlload*txt | xargs -n1 basename > list_tables")
	
        handler = open('list_tables','r')
        file = handler.readline()
        while file:
                #print file
                table_name = str(file)
                table_name = table_name [8:]
                table_name = table_name.replace(".txt\n","")
                #print table_name
                file_list.append(file)
                file = handler.readline()
        #print file_list
	handler1 = open('list_tablescore','w')
	for temp in file_list:
		if (temp == 'CALEND16'):
			pass
		else:
			tables =tables +temp
	handler1.write(tables)
	handler1.close()
	os.system("mv sql_export62/sqlload_CALEND16.txt_bakk sql_export62/sqlload_CALEND16.txt")
	#print file_list
        return file_list


def main():
        list_of_tables = fileList()
	list_of_tables_f = []
	for tab in list_of_tables:
		tab = tab[8:]
		tab = tab.replace(".txt\n","")
		list_of_tables_f.append(tab)
        list_table_with_more_attribute = ['MEMBERLN','LST_GRP','CALEND16']
        handler = open('AllSql.cmd','r')
        query = handler.readline()
        query_final = ''
        while query:
                #print query
                temp_query = query.split('|')
		#print temp_query[0]	
		temp  = temp_query[0]
                if temp in list_of_tables_f:
                        if temp not in list_table_with_more_attribute:
                                query_final = query_final + query
                query = handler.readline()
        #print query_final
        handler_query = open('sql_common.cmd','w')
        handler_query.write(query_final)
        #handler_query.write(str(list_of_tables))
        handler_query.close()
	"""
	h = open('list_tablescore','a')
	h.write('sqlload_MEMBERLN.txt\n')
	h.write('sqlload_CUSTOM.txt')
	h.close()
	"""
	os.system("mv list_tablescore list_tablesvn")
if __name__ == "__main__":
        main()

