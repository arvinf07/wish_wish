

class WishController < ApplicationController

  get '/wishes/new' do 
    if !logged_in?
      redirect "/failure"
    end
    erb :'wish/new'  
  end  

  post '/wishes' do 
    wish = Wish.new(name: params[:name].strip)
    binding.pry
    if !wish.save
      #display errors with either rack-flash or active record error messages
      redirect '/wishes/new'
    end  

  end
  
  
end
  