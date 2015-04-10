require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative './models/user'

class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'superbly secret'

  get '/' do
    erb :index
  end

  post '/users' do
    User.create(email: params[:email],
                name: params[:name],
                password: params[:password],
                username: params[:username])
    "Welcome #{params[:name].split(' ').first}!"
  end

  post '/sessions/new' do
    user = User.first(email: params[:returning_email])
    session[:name] = user.name.split(' ').first
    "Welcome #{session[:name]}!"
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

end
