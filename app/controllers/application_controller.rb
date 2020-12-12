require './config/environment'

class ApplicationController < Sinatra::Base
  # use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    set :show_exceptions, false
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    end  
    erb :welcome
  end

  not_found do 
    status 404
    erb :error
  end  

  error ActiveRecord::RecordNotFound do 
    redirect '/'
  end  

  helpers do 
    def logged_in?
      session[:user_id]
    end 

    def current_user
      @current_user ||= User.find(session[:user_id]) if logged_in?
    end  

    def current_wish
      @current_wish ||= Wish.find(params[:id])
    end  
  end  

end

##Should I just make comments an attribute(array) of wishes?
##How can I make a button that adds another comment form ?
