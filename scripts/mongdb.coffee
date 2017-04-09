# Description
#   Item aus Datenbank holen
# https://www.tutorialspoint.com/coffeescript/coffeescript_mongodb.htm
#
# Configuration:
#   MLAB_API_KEY Your Mlab Api Key
#   MLAB_USER_NAME
#   MLAB_USER_PW
#
# Commands:
#   oacitem <Nummer>
#
#
# Author:
#   Kaimodo

mdbPw = process.env.MLAB_USER_PW

#Requiring the Mongodb package
mongo = require 'mongodb'

#Creating a MongoClient object
MongoClient = mongo.MongoClient

#Preparing the URL
url = 'mongodb://Kaimodo:'+mdbPw+'@ds157390.mlab.com:57390/resitems'

#Connecting to the server
MongoClient.connect url, (err, db) ->
  if err
    console.log 'MongoDB: Unable to connect . Error:', err
  else
    console.log 'MongoDB: Connection established to', url
    #Finding Data
    col = db.collection('items_de.oac-head.com_2')    
    #Inserting Documents
    #findOne({"username" : /.*son.*/i});
    col.findOne({Name: /.*zit.*/i}).toArray (err, result)->
      if err
        console.log err
      else 
      console.log 'Found:', result			
      #Closing connection
      db.close()
      return
  return
