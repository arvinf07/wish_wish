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

  post '/users/login' do 
    user = User.find_by_username(params[:username])
    if !user
      redirect '/users/signup'
    end  
    user.authenticate(params[:password])
  end  

  post '/users/signup' do
    User.create(params)
    redirect '/users/login'
  end  
  
  
end  