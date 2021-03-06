require 'pry'

class UserController < ApplicationController
  ##Make route to edit a users' username

  get '/users' do
    if !logged_in? 
      redirect '/'  
    else
      @users = User.all
      erb :'/user/index'
    end  
  end  

  get '/users/signup' do 
    if logged_in?
      redirect "/users/#{current_user.id}"
    end  
    erb :'user/signup'
  end  

  get '/users/logout' do 
    session.clear
    redirect '/users/login'
  end  

  get '/users/login' do 
    if logged_in?
      redirect "/users/#{current_user.id}"
    end  
    erb :'user/login'
  end  

  get '/users/:id' do 
    if logged_in?
      @other_user = User.find(params[:id]) if current_user.id != params[:id].to_i
      erb :'/user/show'
    else
      redirect '/users/login'  
    end
  end  

  post '/users/login' do 
    params[:username] = params[:username].strip
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    end  
    erb :failure
  end  

  # post '/users/signup' do  ##Use valid? here
  #   params[:username] = params[:username].strip
  #   if !User.find_by_username(params[:username])
  #     user = User.create(params)
  #     session[:user_id] = user.id
  #     redirect '/users/login'
  #   end  
  #   #Show error messages in login page
  #   erb :failure
  # end  
  
  post '/users/signup' do  ##Use valid? here
    params[:username] = params[:username].strip
    user = User.create(params)
    if user.valid?
      session[:user_id] = user.id
      redirect '/users/login'
    end  
    #Show error messages in login page
    erb :failure
  end  
  
  
end  