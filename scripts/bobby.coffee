# Kommentar damit der Build nicht meckert
# http://slidedeck.io/ajacksified/how-to-hubot
module.exports = (robot) ->
  robot.hear /bobby.burger/, (res) ->
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
    payload.content.pretext = 'Bibby Burger :whopper:'
    #payload.content.title = String(result[nummer].Name)
    #payload.content.title_link = String(result[nummer].url)
    #payload.content.text = String(result[nummer].AllData)
    #payload.content.thumb_url = String(result[nummer].Picture)
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