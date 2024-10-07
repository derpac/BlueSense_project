# Note: files 0-1 are +ve and -ve z-axis respectively, 2-3 are +ve and -ve y-axis and 4-5 are +ve and -ve x-axis.



# find a specific few seconds and find the average of those results


import csv
import matplotlib.pyplot as plt

pos_z =[]
neg_z =[]

neg_y =[]
pos_y =[]

pos_x =[]
neg_x =[]

def extract_column_data(file_name, column):
  data = []
  with open(file_name, mode='r') as file:
        csv_reader = csv.reader(file)
        for row in csv_reader:
            if len(row) >= column:  
                try:
                  
                    data.append(float(row[column - 1])) 
                except ValueError:
                    
                    pass
  return data

def calculate_average(data):
    if len(data) > 0:
        return sum(data) / len(data)
    else:
        return 0

def calculate_bounds(data):
    if len(data) > 0:
        return min(data), max(data)
    else:
        return 0, 0 

for file_index in range(6):
    file_name = f'Min-Max-Tests\87FA\LOG-87FA.00{file_index}'
    
    if file_index == 0:
        pos_z = extract_column_data(file_name, 7)
    
    elif file_index == 1:
        neg_z = extract_column_data(file_name, 7)
    elif file_index == 2:
        pos_y = extract_column_data(file_name, 6) 
    elif file_index == 3:     
        neg_y = extract_column_data(file_name, 6)
    elif file_index == 4:    
        neg_x = extract_column_data(file_name, 5)
    elif file_index == 5: 
        pos_x = extract_column_data(file_name, 5)

print("Max-z: ",calculate_average(pos_z), "Min-z: ",calculate_average(neg_z))
print("Max-y: ",calculate_average(pos_y), "Min-y: ",calculate_average(neg_y))
print("Max-x: ",calculate_average(pos_x), "Min-x: ",calculate_average(neg_x))
data = [
    ('File 0', pos_z),
    ('File 1', neg_z),
    ('File 2', pos_y),
    ('File 3', neg_y),
    ('File 4', pos_x),
    ('File 5', neg_x)
]

means = []
lower_bounds = []
upper_bounds = []
labels = []

for label, file_data in data:
    mean = calculate_average(file_data)
    lower, upper = calculate_bounds(file_data)
    
    
    means.append(mean)
    lower_bounds.append(mean - lower)  
    upper_bounds.append(upper - mean)  
    labels.append(label)


plt.figure(figsize=(10, 6))
plt.errorbar(labels, means, yerr=[lower_bounds, upper_bounds], fmt='o', capsize=5, capthick=2, elinewidth=1)


plt.xlabel('Files')
plt.ylabel('Values')
plt.title('Mean, Lower Bound, and Upper Bound of Columns for Each File')
plt.grid(True)
plt.show()


print("Max-z:",calculate_average(pos_z))