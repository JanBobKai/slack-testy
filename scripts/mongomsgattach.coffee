# Description
#   Get Item from M-Lab MongoDB ant show results in an Attachment-Message
#
# Configuration:
#   MLAB_CONN_STRING -> mongodb://<username>:<pw>@xxx.mlab.com:57390/<db>
#
# Commands:
#   oc.item <Name>
#
# Dependencies
#   mongodb
#
# Author:
#   Kaimodo

mongo = require('mongodb').MongoClient
Conversation = require('hubot-conversation')

#Connecting to the server
  
module.exports = (robot) ->
    switchBoard = new Conversation(robot)
    robot.hear /oc.item (.*)/i, (res) ->   
        nummer = null     
        searchName = res.match[1]#.toLowerCase() if u don't need Case sensitivity
        console.log 'Eingabe: ', searchName
        url = process.env.MLAB_CONN_STRING
        mongo.connect url, (err, db) ->
            if err
                console.log 'MongoDB: Unable to connect . Error:', err
            else
                console.log 'MongoDB: Connection established to', url                    

            #find Data: SELECT * from DB WHERE <Key> IS LIKE <Input>
            db.collection('items_de.oac-head.com_2').find({ Name: new RegExp(searchName) } , {'limit':3}).toArray (err, result) ->
                if err
                    console.log err
                else
                    console.log 'Found: ', result

                #Error Msg if Item is not present in the DB
                if result.length == 0
                    console.log 'nicht in DB: ', searchName
                    res.send "Sorry Item (noch)nicht in der Datenbank"
                    return
                
                dialog = switchBoard.startDialog(res)
                res.reply 'Welches Item soll gesendet werden?\n'+result[0].Name+'\n'+result[1].Name+'\n'+result[2].Name+'\n'
                dialog.addChoice /1/i, (msg2) ->
                    #msg2.reply 'Ok Item Eins!'
                    nummer = 0
                    room= res.envelope.room
                    timestamp= new Date/1000|0
                    # Attachment "Prototype"
                    payload = 
                        content:
                            text: ''
                            fallback: ''
                            pretext: ''
                            title: ''
                            title_link: ''
                            author_name: ''
                            author_link: ''
                            author_icon: ''
                            thumb_url: ''
                            color: ''
                            footer: ''
                            footer_icon: ''
                            ts: ''
                            fields: []
                    # Fill in Data in Attachment
                    payload.content.pretext = 'Dein gesuchter Gegenstand:'
                    payload.content.title = String(result[nummer].Name)
                    payload.content.title_link = String(result[nummer].url)
                    payload.content.text = String(result[nummer].AllData)
                    payload.content.thumb_url = String(result[nummer].Picture)
                    payload.content.color = '#EEEEEE'
                    payload.content.footer = 'Resis'
                    payload.content.footer_icon = 'https://avatars.slack-edge.com/2017-03-09/151204178657_8ed2b3731b17d14bfdf9_48.png'
                    payload.content.ts = timestamp
                    
                    #Fileds How-to, if u need em
                    #payload.content.fields.push title: 'title', value: "value", short: true
                    #payload.content.fields[].title = 
                    options = { as_user: true, link_names: 1, attachments: payload }

                    # send Msg
                    client = robot.adapter.client
                    client.web.chat.postMessage(room, '', options)
                    return
                dialog.addChoice /2/i, (msg3) ->
                    #msg3.reply 'Ok Item Zwei!'
                    nummer = 1
                    room= res.envelope.room
                    timestamp= new Date/1000|0
                    # Attachment "Prototype"
                    payload = 
                        content:
                            text: ''
                            fallback: ''
                            pretext: ''
                            title: ''
                            title_link: ''
                            author_name: ''
                            author_link: ''
                            author_icon: ''
                            thumb_url: ''
                            color: ''
                            footer: ''
                            footer_icon: ''
                            ts: ''
                            fields: []
                    # Fill in Data in Attachment
                    payload.content.pretext = 'Dein gesuchter Gegenstand:'
                    payload.content.title = String(result[nummer].Name)
                    payload.content.title_link = String(result[nummer].url)
                    payload.content.text = String(result[nummer].AllData)
                    payload.content.thumb_url = String(result[nummer].Picture)
                    payload.content.color = '#EEEEEE'
                    payload.content.footer = 'Resis'
                    payload.content.footer_icon = 'https://avatars.slack-edge.com/2017-03-09/151204178657_8ed2b3731b17d14bfdf9_48.png'
                    payload.content.ts = timestamp
                    
                    #Fileds How-to, if u need em
                    #payload.content.fields.push title: 'title', value: "value", short: true
                    #payload.content.fields[].title = 
                    options = { as_user: true, link_names: 1, attachments: payload }

                    # send Msg
                    client = robot.adapter.client
                    client.web.chat.postMessage(room, '', options)
                    return
                dialog.addChoice /3/i, (msg4) ->
                    #msg4.reply 'Ok Item Drei!'
                    nummer = 2
                    room= res.envelope.room
                    timestamp= new Date/1000|0
                    # Attachment "Prototype"
                    payload = 
                        content:
                            text: ''
                            fallback: ''
                            pretext: ''
                            title: ''
                            title_link: ''
                            author_name: ''
                            author_link: ''
                            author_icon: ''
                            thumb_url: ''
                            color: ''
                            footer: ''
                            footer_icon: ''
                            ts: ''
                            fields: []
                    # Fill in Data in Attachment
                    payload.content.pretext = 'Dein gesuchter Gegenstand:'
                    payload.content.title = String(result[nummer].Name)
                    payload.content.title_link = String(result[nummer].url)
                    payload.content.text = String(result[nummer].AllData)
                    payload.content.thumb_url = String(result[nummer].Picture)
                    payload.content.color = '#EEEEEE'
                    payload.content.footer = 'Resis'
                    payload.content.footer_icon = 'https://avatars.slack-edge.com/2017-03-09/151204178657_8ed2b3731b17d14bfdf9_48.png'
                    payload.content.ts = timestamp
                    
                    #Fileds How-to, if u need em
                    #payload.content.fields.push title: 'title', value: "value", short: true
                    #payload.content.fields[].title = 
                    options = { as_user: true, link_names: 1, attachments: payload }

                    # send Msg
                    client = robot.adapter.client
                    client.web.chat.postMessage(room, '', options)
                    return



                console.log 'nummer = ', nummer

                #Prepare Message
                                