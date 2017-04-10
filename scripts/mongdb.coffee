# Description
#   Item aus Datenbank holen
# https://www.tutorialspoint.com/coffeescript/coffeescript_mongodb.htm
# http://theholmesoffice.com/how-to-ge-data-from-mongodb-into-node-js/
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

#Requiring the Mongodb package
mongo = require 'mongodb'
mdbPw = process.env.MLAB_USER_PW

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
    #richtige Tabelle nehmen
    col = db.collection('items_de.oac-head.com_2')
        
    module.exports = (robot) ->
        robot.hear /oac.item (.*)/i, (res) ->
            artistName = res.match[1].toLowerCase()
            if artistName is ""
              res.send "kein Name angegeben"
            else
            searchName = artistName
            console.log 'Eingabe: ', searchName
            

            #Daten finden
            col.find({ Name: /Zit/i } , {'limit':1}).toArray (err, result) ->
            if err
                console.log err
            else
                console.log 'Found:', result
            #Closing connection
            db.close()
            return
            return

            # https://api.slack.com/docs/message-attachments
            room = res.envelope.room
            timestamp = new Date/1000|0
            attachments = [ {
                fallback: 'dungeonChars',
                color: 'danger',
                pretext: 'Gebrauchte Charaktere je Dungeon',
                fields: [ {
                    title: 'Name',
                    value: result[0].Name,
                    short: true
                }, {
                    title: 'RTL',
                    value: ':heal: | :gazer: | :tank: | :tank:'
                }
                ]
            }, {
                fallback: 'test',
                color: 'grey',
                footer: 'resis',
                footer_icon: 'https://avatars.slack-edge.com/2017-03-09/151204178657_8ed2b3731b17d14bfdf9_48.png',
                ts: timestamp
            }
            ]

            options = { as_user: true, link_names: 1, attachments: attachments }

            client = robot.adapter.client
            client.web.chat.postMessage(room, '', options)