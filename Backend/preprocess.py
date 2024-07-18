from genericpath import isfile
import re
import os
count=0
c=""
datasetpath="D:\\rohan\\Documents\\"
# os.remove(r"D:\rohan\Documents\License_detection\Label\Label.txt")
with open(datasetpath+"\\lice\\cropped\\Label.txt",'r') as file, open(datasetpath+"\\License_detection\\Label\\temp.txt",'a+') as newfile:
    lines=file.readlines()
    for line in lines:
        a=line.split("\"")
        if len(a)<10:
            if re.match('^\w+$',a[3]):
                count=count+1
                for i in a:
                    c="\""+i
                    newfile.write(c)
            else:
                a[3]=re.sub('[\W_]',"",a[3])
                count=count+1
                for i in a:
                    c="\""+i
                    newfile.write(c)
        else:
            if re.match('^\w+$',a[3]) and re.match('^\w+$',a[11]):
                count=count+1
                for i in a:
                    c="\""+i
                    newfile.write(c)
            else:
                if re.match('^\w+$',a[3]):
                    if re.match('^\w+$',a[11]):
                        pass
                    else:
                        a[11]=re.sub('[\W_]',"",a[11])
                        for i in a:
                            c="\""+i
                            newfile.write(c)
                else:
                    a[3]=re.sub('[\W_]',"",a[3])
                    if re.match('^\w+$',a[11]):
                        for i in a:
                            c="\""+i
                            newfile.write(c)
                    else:
                        a[11]=re.sub('[\W_]',"",a[11])
                        for i in a:
                            c="\""+i
                            newfile.write(c)
                            
file.close()
newfile.close()
#to remove first column "
with open(datasetpath+"\\lice\\cropped\\Label\\Label.txt",'a+') as file1, open(datasetpath+"\\License_detection\\Label\\temp.txt",'r') as newfile1:
    lines1=newfile1.readlines()
    for line in lines1:
        file1.writelines(line[1:])
newfile1.close()
file1.close()
#remove temp file
if os.path.isfile(datasetpath+"\\License_detection\\Label\\temp.txt"):
    os.remove(datasetpath+"\\License_detection\\Label\\temp.txt")
    print("Temp File removed")
else:
    print("Temp file does not exist")