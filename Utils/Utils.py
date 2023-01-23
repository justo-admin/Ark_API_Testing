import json
import ast
import string
import os

# Function to rename multiple files
def rename_allfiles():
    i = 0
    path="E:/Downloads/Sample Images/"
    for filename in os.listdir(path):
        my_source =path + filename
        my_dest ="Image" + str(i) + ".jpg"
        my_dest =path + my_dest
        # rename() function will
        # rename all the files
        os.rename(my_source, my_dest)
        i += 1

rename_allfiles()