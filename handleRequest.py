import urllib.request
import requests
import json
import compareImages
import os

def downloadStickers() :
    pass

def findSticker() :
    pass


firebase_url = "https://test1-897a6.firebaseio.com/" # URL of Database
table = "Requests"
r = requests.get(firebase_url + table + ".json")
data = json.loads(r.text)
print(data)


#################################################
# Handle requests one by one.
# First download the request(UserKey, photo)
# Find the sticker that matches with the photo user sent
# Write the stickerKey on the database
#################################################

updatedRequests=dict() #generate a dictionary of requests that are processed.

for re in data :
    userKey = data[re]['from']
    rPhoto = data[re]['photoURL']
    file_name = 'Photo.png'
    file_path = "\\" + userKey


    urllib.request.urlretrieve(rPhoto, 'C:/Users/Hye-lee/Desktop' + file_path + "/" + file_name) # download the photo user sent to the folder of userKey

    '''
    ##### Image Comparison ####
    #Find the sticker that is the same with photo user sent.
    # if found -> return the stickerKey
    # else -> return some kind of error message.(It sohould be compatible with stickerKey
    # Assumed that the names of stickers are stickerKey(Unique ID)

    stickerKey = compareImages.findMatch(userKey, rPhoto) # get the stickerKey that matches with the photo.

    os.remove(file_name) # remove the photo user sent
    #os.chdir('..')  # back to the root directory
'''

    ################################################
    # Yet implemented

    stickerKey = 'test result'

    # Put the processed request in the newRequests. This is done to avoid modifying the list that we iterate.
    data = {'from': userKey, 'photoURL': rPhoto, 'result' : stickerKey }
    updatedRequests[re]=data

    #Delete the existing information
    requests.delete(firebase_url + '/' + table + '/' + re + '.json')

requests.post(firebase_url + '/' + table + '.json', data=json.dumps(updatedRequests))     # Post the result(photoKey or error message) on the database