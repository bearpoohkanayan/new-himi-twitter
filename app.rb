require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'
enable :sessions
helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

  get '/' do
  @posts = current_user.posts
  erb :index
end

get '/post/new' do
  erb :post_new
end

post '/post/new' do
  # Post.create(contents: params[:contents],yaba: params[:yaba])
  current_user.posts.create(contents: params[:contents],yaba: rand(1..5))
  redirect '/post/ok'
end

get '/signup' do
  erb :sign_up
end

post '/signup' do
  user = User.create(
      name: params[:name],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.persisted?
      session[:user] = user.id
    end
    redirect'/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

post '/signin' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signin' do
  erb :sign_in
end

get '/post/new' do
  erb :post_new
end

get '/post/ok' do
  erb :post_ok
end