require 'sendgrid-ruby'
include SendGrid

# TODOs
# TODO: No repeats. Keep track of which lines have been sent. Loop at end.
# TODO: Go through file sequentially, sending one line every time it's run. 
# TODO: Support custom subject lines.

file = ARGV[0]
abort "usage: #{$0} [filename]" unless file

# Select a random message
chosen_line = nil
File.foreach(file).each_with_index do |line, number|
    chosen_line = line if rand < 1.0/(number+1)
end

# Email the message
from = Email.new(email: 'wahahovet@net-list.com')
to = Email.new(email: 'wahahovet@net-list.com')
subject = 'MOTD from '+file;
content = Content.new(type: 'text/plain', value: chosen_line)
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)

# Debug output:
#puts response.status_code
#puts response.body
#puts response.headers
