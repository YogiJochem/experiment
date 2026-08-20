from os import listdir
import cv2

path = "C:/Users/joche/Documents/GitHub/experiment/Battlers"
folders = listdir(path)

M = 192

for folder in folders:
    folderPath = path + '/' + folder
    files = listdir(folderPath)

    for file in files:
        filePath = folderPath + '/' + file
        image = cv2.imread(filePath, cv2.IMREAD_UNCHANGED)
        
        tiles = [image[x:x+M,y:y+M] for x in range(0,image.shape[0],M) for y in range(0,image.shape[1],M)]

        cv2.imwrite(folderPath + '/e' + file, tiles[0])
        cv2.imwrite(folderPath + '/es' + file, tiles[1])
        cv2.imwrite(folderPath + '/a' + file, tiles[2])
        cv2.imwrite(folderPath + '/as' + file, tiles[3])
