require 'sinatra'
require 'data_mapper'

# database setup
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db/cat.db")
class Cat
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :image, Text
end
DataMapper.finalize.auto_upgrade!

get '/' do
  erb :'home/index'
end

get '/cats' do
  @cats = Cat.all
  erb :'cats/index'
end

get '/cats/new' do
  erb :'cats/new'
end

post '/cats' do
  Cat.create({:name => params["name"],:image => params["image"]})
  redirect '/cats'
end

get '/cats/:id' do 
  @cat = Cat.get(params["id"])
  erb :'/cats/show'
end