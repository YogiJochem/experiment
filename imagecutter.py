from os import listdir
import cv2
import numpy as np
from PIL import Image

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
        print(tiles)

        im = Image.fromarray(tiles[0])
        im.save(folderPath + '/e' + file)
        im = Image.fromarray(tiles[1])
        im.save(folderPath + '/es' + file)
        im = Image.fromarray(tiles[2])
        im.save(folderPath + '/a' + file)
        im = Image.fromarray(tiles[3])
        im.save(folderPath + '/as' + file)