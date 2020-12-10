

class WishController < ApplicationController

  get '/wishes/new' do 
    if !logged_in?
      redirect "/failure"
    end
    erb :'wish/new'  
  end  

  post '/wishes' do 
    wish = Wish.create(name: params[:name].strip)
    if !wish
      #display errors with either rack-flash or active record error messages
      redirect '/wishes/new'
    end  
    current_user.wishes << wish
    binding.pry
    redirect "/wishes/#{wish.id}"
  end

  get '/wishes/:id/edit' do
    current_wish
    erb :'wish/edit'
  end

  get '/wishes/:id' do 
    erb :'wish/show'
  end  

  patch '/wishes/:id' do 
    
    redirect "wishes/#{params[:id]}"
  end
 
  delete '/wishes/:id' do 
    Wish.find(params[:id]).destroy
  end  
  
end
  