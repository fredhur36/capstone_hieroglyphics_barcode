import urllib.request
from  urllib.error  import HTTPError
import glob
import requests
import json
import os
import time

dataSize = 0

firebase_url = "https://custombarcode-3b747.firebaseio.com/" # URL of Database
table = "Stickers"

base_path = "C:\\Users\\Hye-lee\\Desktop\\Capstone"

while True :
    try :
        r = requests.get(firebase_url + table + ".json", headers={'user-agent': 'Mozilla/5.0'}, cookies={'session_id': 'sorryidontcare'})
        data = json.loads(r.text)

        if dataSize >= len(str(data)) :
            continue
        dataSize = len(str(data))
        directories = glob.glob(base_path + '\\**\\')
        ##print(directories)
        for user, stickers in data.items() :
            user_dir = base_path + '\\' + user + '\\'
            if user_dir not in directories :
                os.mkdir(user_dir)
            #print(user)
            print(stickers)
            files = glob.glob(user_dir + '*')
            if len(stickers)-1 == len(files) :
                continue
            else :
                index = 1
                for sticker in stickers:
                    try:
                        print(sticker['photoURL'])
                        file_path = user_dir + str(index) + '.jpg'
                        print(file_path)
                        urllib.request.urlretrieve(sticker['photoURL'], file_path)  # download the photo user sent to the folder of userKey
                        index = index + 1
                    except TypeError :
                        pass
    except urllib.error.HTTPError :
        pass

    time.sleep(2)
