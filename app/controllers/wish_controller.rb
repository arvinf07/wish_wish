

class WishController < ApplicationController
  get '/wishes/new' do 
    erb :'wish/new' if logged_in?
    erb :failure
  end
  

  post '/wishes' do          
    wish = Wish.create(name: params[:name].strip)
    if !wish.valid?
      #display errors with either rack-flash or active record error messages
      redirect '/wishes/new'
    end  
    wish.details = params[:details] if params[:details] != ""
    current_user.wishes << wish 
    redirect "/wishes/#{wish.id}"
  end

  get '/wishes/:id/edit' do
    if current_user && current_user.wishes.include?(current_wish)
      erb :'wish/edit'
    else
      erb :not_logged_in
    end
    
  end

  get '/wishes/:id' do 
    erb :'wish/show'
  end  

  patch '/wishes/:id' do 
    current_wish.update(name: params[:name], details: params[:details]) 
    redirect "/wishes/#{params[:id]}"
  end
 
  delete '/wishes/:id' do 
    Wish.find(params[:id]).destroy
    redirect "/users/#{current_user.id}"  
  end  
  
end
