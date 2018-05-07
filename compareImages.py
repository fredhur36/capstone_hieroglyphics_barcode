#!/usr/bin/python
# written by Hur Joon-Hyung a.k.a fredhur
# edited by Hyelee Lee
# What is edited :
# Conduct feature matcing on all files in the userKey directory
# Find the one that has the similarity over 50%
# Return photoKey

# 이 프로그램은 두 이미지를 비교하고, 두 이미지의 비슷한 부분의 갯수를 숫자로 출력해줍니다.
# opencv 라이브러리 피처매칭 방식을 이용하였으며, 약간의 성능개선을 위한 코드가 추가되어있다.
# 
import sys
import numpy as np
import cv2 
import glob, os

base_path = "C:/Users/Hye-lee/Desktop"

def featureMatching(source_img, dest_img):  # source image 와 dest_img를 피처매칭 해준다 -> 매치점의 개수를 return한다.
    img1 = cv2.imread(source_img, cv2.IMREAD_GRAYSCALE)  # read source_img(흑백으로 읽는다)
    img2 = cv2.imread(dest_img, cv2.IMREAD_GRAYSCALE)

    res = None
    # 피처매칭을 위한 변수들을 설정해줍니다.
    orb = cv2.ORB_create()
    kp1, des1 = orb.detectAndCompute(img1, None)
    kp2, des2 = orb.detectAndCompute(img2, None)

    bf = cv2.BFMatcher()
    matches = bf.knnMatch(des1, des2, k=2)  # 두 이미지에서 비슷한 부분을 ([1,0,0], [2,2,2]) 이렇게 픽셀좌표로 넣어준다.
    # 피처매칭 변수 설정 완료. 피처매칭 완료했음.

    # 여기서부터는 피처매칭된 애들 중, 정말로 거리가 비슷한 매치들만 뽑아냅니다.
    best = []  # 가장 좋은 매치들만 넣을 리스트  선언
    for m, n in matches:
        if (m.distance < 0.8 * n.distance):  # 두 매치의 거리가 80% 정도인 부분만 넣어준다.
            best.append([m])

    return (dest_img, len(best))

def findMatch(UserKey, rPhoto) :
    os.chdir(base_path + "/" + UserKey) #UserKey folder로 이동
    similarStickers =[] #FeatureMatching의 결과를 넣을 list 생성.(photoKey, 매치점의 수)의 형태로 저장된다.

    for file in glob.glob("*.png"): # 폴더 내의 모든 사진 파일에 대해
        a = featureMatching('rPhoto.png', file)
        similarStickers.append(a)

    similarStickers.sort(key = lambda sticker : sticker[1])
    similarStickers.reverse()
    ##print(similarStickers)

    if(similarStickers[1][1]/similarStickers[0][1] > 0.5)  :
        return similarStickers[1][0]
    else :
        return "No such match"
