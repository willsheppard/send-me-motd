# send-me-motd
Email out a Message Of The Day

## to develop
* Set up mail relay, follow [these instructions](https://app.sendgrid.com/guide/integrate/langs/ruby).

## to test
* [Temp-Mail](https://temp-mail.org) has been tested as working. MailMeTrash, Mailinator and Gmail all failed to process the message.

## crontab example
    MOTDPATH=/home/dude/dev/send-me-motd
    # m h  dom mon dow   command
    0 6  *   *   *     /usr/bin/ruby $MOTDPATH/send-me-motd.rb '$MOTDPATH/data/children1.txt' 'xxx-sendgrid-key-here-xxx' 'your-email@example.com' 'do-not-reply@example.com' >> $MOTDPATH/log.stdout 2>> $MOTDPATH/log.stderr
