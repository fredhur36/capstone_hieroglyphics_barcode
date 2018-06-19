import urllib.request
from urllib.error import HTTPError
import requests
import json
import compareImages
import os


firebase_url = "https://custombarcode-3b747.firebaseio.com/" # URL of Database
table = "Request"
base_path = "C:\\Users\\Hye-lee\\Desktop\\Capstone"
file_name = 'rPhoto.jpg'


while True :
    try :
        r = requests.get(firebase_url + table + ".json", headers={'user-agent': 'Mozilla/5.0'}, cookies={'session_id': 'sorryidontcare'})
        data = json.loads(r.text)

        #################################################
        # Handle requests one by one.
        # First download the request(UserKey, photo)
        # Find the sticker that matches with the photo user sent
        # Write the stickerKey on the database
        #################################################


        for re in data.keys() :
            if data[re]['result'] != 'empty' :
                continue
            userKey = data[re]['from']
            rPhoto = data[re]['photoURL']
            file_path = base_path + "\\" + userKey

            urllib.request.urlretrieve(rPhoto, file_path + '\\' + file_name) # download the photo user sent to the folder of userKey


            ##### Image Comparison ####
            #Find the sticker that is the same with photo user sent.
            # if found -> return the stickerKey
            # else -> return some kind of error message.(It sohould be compatible with stickerKey
            # Assumed that the names of stickers are stickerKey(Unique ID)


            stickerKey = compareImages.findMatch(userKey, rPhoto) # get the stickerKey that matches with the photo.
            os.remove(file_name) # remove the photo user sent
            #os.chdir('..')  # back to the root directory

            print(stickerKey)
            ##stickerKey = 'test result'

            #Update the result
            resp = requests.patch(f'{firebase_url}/{table}/{re}.json', data=json.dumps({'result' : stickerKey}))
            ##print(resp)
            ##print(resp.text)
    except HTTPError :
        pass
