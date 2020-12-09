require 'pry'

class UserController < ApplicationController
  
  get '/users' do 
    @user = User.all 
    erb :'user/index'
  end  

  get '/users/signup' do 
    if logged_in?
      redirect "/users/#{current_user.id}"
    end  
    erb :'user/signup'
  end  

  get '/users/login' do 
    if logged_in?
      redirect "/users/#{current_user.id}"
    end  
    erb :'user/login'
  end  

  get '/users/:id' do 
    erb :'/user/show'
  end  

  post '/users/login' do 
    params[:username] = params[:username].strip
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    end  
    erb :'user/failure'
  end  

  post '/users/signup' do
    params[:username] = params[:username].strip
    User.create(params)
    redirect '/users/login'
  end  
  
  
end  