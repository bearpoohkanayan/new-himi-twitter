require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'
enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
  
  def require_login
    redirect '/signup' unless current_user
  end
end

get '/' do
  require_login
  @exchange_posts = current_user.exchanged_posts
  @posts = current_user.posts
  erb :index
end

get '/post/new' do
  erb :post_new
end

post '/post/new' do
  yaba_value = rand(1..5)
  @yaba = yaba_value
  @contents = params[:contents]
  current_user.posts.create(contents: @contents, yaba: @yaba)
  
  redirect "/post/ok"
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
    redirect '/'
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
  erb :sign_up
end

get '/post/new' do
  erb :post_new
end

get '/post/ok' do
  erb :post_ok
end

post '/shop' do
  require_login
  user_yaba = current_user.total_yaba_count # ユーザーが持っているyaba数を取得
  @post = Post.where('yaba < ?', user_yaba).order("RANDOM()").first # yaba値がユーザーのyaba数より低い投稿をランダムに1つ選択
  current_user.exchange_posts.create(post_id: @post.id)
  redirect '/'
end
