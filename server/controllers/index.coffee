rjson = require 'request-json'
rjc = rjson.JsonClient

client = new rjc 'http://localhost:9101/'
client.setBasicAuth process.env.NAME || 'hermes', process.env.TOKEN || 'token'

module.exports.mail = (req, res) ->
    from = req.param 'from'
    subject = req.param 'subject'
    content = req.param 'content'

    if not from? or not subject? or not content?
        res.send 400, 'missing attributes from hermes side'
        return

    data =
        from:    from
        subject: subject
        content: content

    client.post 'mail/to-user', data, (err, resp, body) ->
        if err? or resp.statusCode is 500
            console.error err
            res.send 500, 'error when sending mail'
            return
        if body.error?
            console.error 'Error in body: ', body.error
            res.send 500, body.error
            return
        if resp.statusCode is 400
            console.error resp
            res.send 400, 'missing attributes'
            return

        res.send 200, 'mail sent'

