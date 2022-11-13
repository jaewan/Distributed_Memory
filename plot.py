import numpy as np
import matplotlib.pyplot as plt
import argparse
import csv
import pandas as pd

parser = argparse.ArgumentParser()
parser.add_argument('--file0', type=argparse.FileType('r'), default=None)
parser.add_argument('--file1', type=argparse.FileType('r'), default=None)
parser.add_argument('--file2', type=argparse.FileType('r'), default=None)
parser.add_argument('--file3', type=argparse.FileType('r'), default=None)
parser.add_argument('--file4', type=argparse.FileType('r'), default=None)
args = parser.parse_args()
f_path0 = args.file0
f_path1 = args.file1
f_path2 = args.file2
f_path3 = args.file3
f_path4 = args.file4
x = []
y = []
SD_error = [] # error containing SDs
range_error = [] # error containing max - min

f = open(f_path0.name, 'r')
csv_reader0 = csv.reader(f)
headers = next(csv_reader0)
plt.xlabel(headers[0] + ' (GB)') #object memory store
plt.ylabel(headers[1] + ' (throughput)') #delta/throughput
first_data = []

for row in csv_reader0:
    first_data.append(row)
temp_x = []
temp_y = []
for i in range(len(first_data)):
    temp_x.append(int(float(first_data[i][0]))) # maybe not necessary bc x value is constant, but just in case I did the object memory store wrong
    temp_y.append(int(float(first_data[i][1])))
average = sum(temp_x) / len(temp_x)
SD_error.append(np.std(temp_y)) # appending SD error
range_error.append(max(temp_y) - min(temp_y)) # appending range error
x.append(average)
average = sum(temp_y) / len(temp_y)
y.append(average)
f.close()

f1 = open(f_path1.name, 'r')
csv_reader1 = csv.reader(f1)
headers = next(csv_reader1)

second_data = []
for row in csv_reader1:
    second_data.append(row) #error here 
temp_x = []
temp_y = []
for i in range(len(second_data)):
    temp_x.append(int(float(second_data[i][0])))
    temp_y.append(int(float(second_data[i][1])))
average = sum(temp_x) / len(temp_x)
SD_error.append(np.std(temp_y)) # appending SD error
range_error.append(max(temp_y) - min(temp_y)) # appending range error
x.append(average)
average = sum(temp_y) / len(temp_y)
y.append(average)
f1.close()

f2 = open(f_path2.name, 'r')
csv_reader2 = csv.reader(f2)
headers = next(csv_reader2)

third_data = []
for row in csv_reader2:
    third_data.append(row)
temp_x = []
temp_y = []

for i in range(len(third_data)):
    temp_x.append(int(float(third_data[i][0])))
    temp_y.append(int(float(third_data[i][1])))
average = sum(temp_x) / len(temp_x)
SD_error.append(np.std(temp_y)) # appending SD error
range_error.append(max(temp_y) - min(temp_y)) # appending range error
x.append(average)
average = sum(temp_y) / len(temp_y)
y.append(average)
f2.close()

f3 = open(f_path3.name, 'r')
csv_reader3 = csv.reader(f3)
headers = next(csv_reader3)

fourth_data = []
for row in csv_reader3:
    fourth_data.append(row)
temp_x = []
temp_y = []

for i in range(len(fourth_data)):
    temp_x.append(int(float(fourth_data[i][0])))
    temp_y.append(int(float(fourth_data[i][1])))
average = sum(temp_x) / len(temp_x)
SD_error.append(np.std(temp_y)) # appending SD error
range_error.append(max(temp_y) - min(temp_y)) # appending range error
x.append(average)
average = sum(temp_y) / len(temp_y)
y.append(average)
f3.close()

f4 = open(f_path4.name, 'r')
csv_reader4 = csv.reader(f4)
headers = next(csv_reader4)

fifth_data = []
for row in csv_reader4:
    fifth_data.append(row)
temp_x = []
temp_y = []

for i in range(len(fifth_data)):
    temp_x.append(int(float(fifth_data[i][0])))
    temp_y.append(int(float(fifth_data[i][1])))
average = sum(temp_x) / len(temp_x)
SD_error.append(np.std(temp_y)) # appending SD error
range_error.append(max(temp_y) - min(temp_y)) # appending range error
x.append(average)
average = sum(temp_y) / len(temp_y)
y.append(average)
f4.close()

#print(x_data[0][0]) -> this is how to access elements

# error bars (max - min) - refer to range_error

# error bars (SD) - refer to SD_error
convert = 1000000000
labels = []
for i in range(len(x)):
    labels.append(str(x[i] / convert))
print(labels)
x_pos = [0, 1, 2, 3, 4]
plt.title("Performance changes over object store capacity change")
plt.bar(x_pos, y, yerr=SD_error, align='center', ecolor='black', capsize=10, width=0.5) # can use range_error
plt.xticks(x_pos, labels)
plt.savefig("output.jpg")

