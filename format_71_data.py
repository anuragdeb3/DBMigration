import sys
import os

def main():
        for file in os.listdir('.'):
		#print file
                if file.endswith(".txt"):
			#print(file);
                       formatter(file)

def formatter(file):
	#print file
	path = "Verify71/"
	full_path = path + file
        fp_71 = open(file,"r")
        write_handle = open(path+"sqlload_"+file,"w")
        line71 = fp_71.readlines()
        data = ""
        data_chunk = ""
        for f in line71:
                #print f.strip()
                list71 = f.split(',');
                #print list71
                for d in list71:
                        #print d.strip()
                        data = data + d.strip() + ","
        #print data+';'
		data = data[:-1]
        #write_handle.write(data+';')
        #write_handle.write("\n")
        	data_chunk = data_chunk + data + "\n" 
        	data =""

        write_handle.write(data_chunk)

        write_handle.close();





if __name__ == "__main__":
        main()
