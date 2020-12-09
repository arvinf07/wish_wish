

class WishController < ApplicationController

  get '/wishes/new' do 
    if !logged_in?
      redirect "/failure"
    end
    erb :'wish/new'  
  end  

  post '/wishes' do 
    binding.pry
    Wish.create(params[:name])
    
  end
  
  
end
  