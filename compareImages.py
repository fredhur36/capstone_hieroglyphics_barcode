#!/usr/bin/python
# written by Hur Joon-Hyung a.k.a fredhur
#
# 이 프로그램은 두 이미지를 비교하고, 두 이미지의 비슷한 부분의 갯수를 숫자로 출력해줍니다.
# opencv 라이브러리 피처매칭 방식을 이용하였으며, 약간의 성능개선을 위한 코드가 추가되어있다.
# 
import sys
from sys import argv
import numpy as np
import cv2 

def featureMatching(source_img, dest_img): # source image 와 dest_img를 피처매칭 해준다
    img1 = cv2.imread(source_img,cv2.IMREAD_GRAYSCALE) # read source_img(흑백으로 읽는다)
    img2 = cv2.imread(dest_img,cv2.IMREAD_GRAYSCALE)   # read dest_img( 흑백으로 읽는다)
    res = None
    # 피처매칭을 위한 변수들을 설정해줍니다.
    orb = cv2.ORB_create()
    kp1, des1 = orb.detectAndCompute(img1,None)
    kp2, des2 = orb.detectAndCompute(img2,None)

    bf = cv2.BFMatcher()
    matches = bf.knnMatch(des1, des2,k=2) # 두 이미지에서 비슷한 부분을 ([1,0,0], [2,2,2]) 이렇게 픽셀좌표로 넣어준다.
    # 피처매칭 변수 설정 완료. 피처매칭 완료했음.
    
    # 여기서부터는 피처매칭된 애들 중, 정말로 거리가 비슷한 매치들만 뽑아냅니다.
    best=[] # 가장 좋은 매치들만 넣을 리스트  선언
    for m,n in matches:
        if (m.distance < 0.8*n.distance):# 두 매치의 거리가 80% 정도인 부분만 넣어준다. 
                        best.append([m])
    
    print(len(best)) # 실제로 비슷한 부분의 개수를 숫자로 나타내었다.

def main():
    script, source_img, dest_img = argv # 콘솔명령어로 이미지 두개를 받는다. 작동방식은 readme.txt 에 설명함.
    featureMatching(source_img, dest_img)
    while True: #종료 조건.  q 버튼을 누르고 엔터를 치면 종료된다.
        quit_message=input()
        if(quit_message == 'q'): sys.exit()
    
if __name__ == '__main__':
    main()

