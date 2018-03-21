# capstone_hieroglyphics_barcode

We try to make a customized barcode.  
That is, a user can register a sticker by photo and attach a message on it.  
When he or she takes a picture of that sticker, a message would pop up.  

Ideally, a sticker is a photo but with somekind of fixed background. So that the sticker would not change wherever it is attached.  
It is different from detecting an image that is in other background. We would only determine whether the photo that user took is the same photo with the reigsterd photo.  
Thus the sticker should not be changed. It should have square shape(or, any shape but it should not be changed).


## Reigster
1. Take a photo of the sticker
2. Or choose a photo from gallery
3. Take a message input
4. Update the database with a photo and message.
  It is done by writing a photoURL and a message on Stickers/user in the database.


## Detect the sticker and print out the message
1. Take a photo of the sticker
2. Or choose a photo from gallery
3. Write a request with User key and a photo URL on Requests table in the database.
4. Find the sticker in the database that is the same with the photo user took.
>  1) Python keeps checking the length of the Requests table in the database.
>  2) When it increases, read the new request.
>  3) Checks whether there is a sticker in the database that is the same with the photo user had taken.
>  4) Write the result(key of the photo) on the request node. (Use key of the photo instead of message to make it editable)
5. When request node is updated, iPhone gets the result from the request node.
6. Follow the key of the photo and print out the result.


## Show the list of stickers and edit the message
1. Show the sticker saved in the database
2. Choose the sticker
3. Edit the message
4. Update the database.

## Database structure
![alt text](/DB_structure.png )

## Additional functions(If time permits)
* sharing the sticker.  
  To do this, we need to save the data on the photo that who is linked with that sticker.
