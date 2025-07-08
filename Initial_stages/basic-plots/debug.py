df = pd.read_csv(file_path, header=None)

# Check the number of columns and inspect the data
print(df.shape)  # Print the shape to see how many rows and columns are in the data
print(df.head())  # Print the first few rows to visually inspect the data