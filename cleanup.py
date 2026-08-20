from os import listdir
from os import remove

path = "C:/Users/joche/Documents/GitHub/experiment/Battlers"
folders = listdir(path)
keywords = ["a","e"]

for folder in folders:
    folderPath = path + '/' + folder
    files = listdir(folderPath)

    for file in files:
        if not any(word in file for word in keywords):
            filePath = folderPath + '/' + file
            print("removed " + filePath)
            remove(filePath)