import json
import ast
import string
import pandas as pd
import csv

userlist = "Source\\UserIds.csv"
userlist2 = "Source\\UserIds2.csv"

def getUserFromFile():
    sourcedf = pd.read_csv(userlist2,encoding="utf-8-sig")
    currentUser_firstname = sourcedf.FirstName[0]
    currentUser_lastname = sourcedf.LastName[0]
    currentUser_mobile = sourcedf.Mobile[0]
    currentUser_email = sourcedf.Email[0]
    currentUser_password = sourcedf.Password[0]
    print(currentUser_firstname, currentUser_lastname, currentUser_mobile, currentUser_email, currentUser_password)
    sourcedf.drop(0,axis=0,inplace=True)
    sourcedf.to_csv(userlist2,index=False)
    return [currentUser_firstname, currentUser_lastname, str(currentUser_mobile), currentUser_email, currentUser_password]

#getUserFromFile()
