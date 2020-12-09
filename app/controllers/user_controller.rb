require 'pry'

class UserController < ApplicationController
  
  get '/users' do 
    @user = User.all 
    erb :'user/index'
  end  

  get '/users/signup' do 
    erb :'user/signup'
  end  

  get '/users/login' do 
    erb :'user/login'
  end  

  get '/users/:id' do 
    current_user
    binding.pry
    erb :'/user/show'
  end  

  post '/users/login' do 
    params[:username] = params[:username].strip
    user = User.find_by_username(params[:username])
    binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    end  
    erb :'user/failure'
    redirect '/users/signup'
  end  

  post '/users/signup' do
    params[:username] = params[:username].strip
    User.create(params)
    redirect '/users/login'
  end  
  
  
end  