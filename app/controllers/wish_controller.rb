

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
    redirect '/wishes/:id'
  end

  get '/wishes/:id/edit' do
    current_wish
    erb :'wish/edit'
  end

  get '/wishes/:id' do 
    current_wish
    erb :'wish/show'
  end  

  patch '/wishes/:id' do 
    
    redirect "wishes/#{params[:id]}"
  end
 
  delete '/wishes/:id' do 
    Wish.find(params[:id]).destroy
  end  
  
end
  