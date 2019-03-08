require 'sendgrid-ruby'
include SendGrid

require 'date'

# TODOs
# TODO: No repeats. Keep track of which lines have been sent. Loop at end.
# TODO: Go through file sequentially, sending one line every time it's run. 
# TODO: Support multiple recipients, comma separated

# DONE: Support custom subject lines.

file = ARGV[0]
sendgrid_key = ARGV[1]
to_address = ARGV[2]
abort "usage: #{$0} [filename] [key] [email]" unless file && sendgrid_key

ENV["SENDGRID_API_KEY"] = sendgrid_key
to_address ||= 'wahahovet@net-list.com'; # default to a test address

# Select a random message
lines = File.readlines(file)
heading = lines.shift
chosen_line = lines.sample
chosen_line.chomp!

# Email the message
from = Email.new(email: to_address)
to = Email.new(email: to_address)
subject = heading;
content = Content.new(type: 'text/plain', value: chosen_line)
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)

# Debug output:
#puts response.status_code
#puts response.body
#puts response.headers

timestamp = Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
puts "#{timestamp}: sent '#{chosen_line}' to #{to_address}"
