require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop2.db"


class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
  # user_name, email, date_stamp, barber
  @username = params[:username]
  @datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]
	@phone = params[:phone]



  erb "<h2>Thank You for the visit</h2>"
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do

	@name = params[:name]
	@email = params[:email]
	@message = params[:message]


	erb "<h2>Thank You. We will deal with your message ASAP</h2>"
end
