# Resource: https://github.com/AlexeyAB/darknet
# <x_center> <y_center> <width> <height> - float values relative to width and height of image,
# it can be equal from (0.0 to 1.0]
# <x> = <absolute_x> / <image_width>
# <height> = <absolute_height> / <image_height>
# attention: <x_center> <y_center> - are center of rectangle (are not top-left corn

import glob
import os
import cv2
c=0
for iml in ["jpg","png","jpeg"]:
    for i in glob.glob(r"D:\rohan\Downloads\lice\*."+iml):
        c=c+1
        sumne=i.split(".")[:-1]
        abc=""
        for j in sumne:
            if abc == "":
                abc=j
            else:
                abc=abc+"."+j
        image=cv2.imread(i)
        dh, dw, _ = image.shape
        with open (abc+".txt","r") as f:
            # print(f)
            for box in f.readlines():
                # print(line)
                # box = "1 0.615234 0.254688 0.148438 0.178125"
                class_id, x_center, y_center, w, h = box.strip().split()
                x_center, y_center, w, h = float(x_center), float(y_center), float(w), float(h)
                x_center = round(x_center * dw)
                y_center = round(y_center * dh)
                w = round(w * dw)
                h = round(h * dh)
                x = round(x_center - w / 2)
                y = round(y_center - h / 2)

                imgCrop = image[y:y + h, x:x + w]
                cv2.imwrite(r"D:\rohan\Downloads\lice\cropped\\"+str(c)+".jpg",imgCrop)