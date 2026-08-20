from os import listdir
from os import remove

path = "C:/Users/joche/Documents/GitHub/experiment/Battlers"
folders = listdir(path)

for folder in folders:
    folderPath = path + '/' + folder
    files = listdir(folderPath)

    for file in files:
        if "egg" in file:
            filePath = folderPath + '/' + file
            print("removed " + filePath)
            remove(filePath)