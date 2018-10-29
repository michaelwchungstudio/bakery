require 'sinatra'
require 'sendgrid-ruby'
include SendGrid

get "/" do
  erb :home
end

get "/about" do
  erb :about
end

get "/products" do
  erb :menu
end

get "/contact" do
  erb :contact
end

get "/email" do
  @email = params[:email]
  @subject = params[:subject]
  @body = params[:body]


  from = Email.new(email: @email)
  to = Email.new(email: 'michaelwchungstudio@gmail.com')
  subject = @subject
  content = Content.new(type: 'text/plain', value: @body)
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  # puts response.status_code
  # puts response.body
  # puts response.headers

  erb :contact
  # redirect "/thanks"
end

# get "/thanks" do
#   erb :thanks
# end
