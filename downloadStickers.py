import urllib.request
import glob
import requests
import json
import os


dataSize = 0

firebase_url = "https://test1-897a6.firebaseio.com/" # URL of Database
table = "Stickers"
r = requests.get(firebase_url + table + ".json")
data = json.loads(r.text)
base_path = "C:/Users/Hye-lee/Desktop"

while True :
    if dataSize > len(str(data)) :
        continue

    directories = glob.glob(base_path)
    for user, stickers in data.items() :
        print(user)
        print(len(stickers))
        print()
        files =  glob.glob(base_path  + '/' +user +'/' + '*')
        if len(stickers) == len(files) :
            continue
        else :
            for sticker in stickers :
                urllib.request.urlretrieve(stickers[sticker]['URL'], base_path + '/' + user + "/" + sticker + '.jpg')  # download the photo user sent to the folder of userKey

    break