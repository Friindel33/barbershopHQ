require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop2.db"

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3 }
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :email, presence: true, email: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3 }
	validates :email, presence: true, email: true
	validates :message, presence: true, length: {maximum: 300 }
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do

@c = Client.new params[:client]
	if @c.save
	  erb "<h2>Thank You for the visit</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
end

get '/contacts' do
	@d = Contact.new
	erb :contacts
end

post '/contacts' do

	@d = Contact.new params[:contact]
	if @d.save
		erb "<h2>Thank You. We will deal with your message ASAP</h2>"
	else
		@error = @d.errors.full_messages.first
		erb :contacts
	end
end

get '/barber/:nickname' do
	@barber = Barber.find_by_nickname (params[:nickname])
	erb :barber
end

get '/bookings' do
  @clients = Client.order('created_at DESC')
	erb :bookings
end

get '/client/:name' do
	@client = Client.find_by_name (params[:name])
	erb :client
end
