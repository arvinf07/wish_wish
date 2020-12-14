

class WishController < ApplicationController
  get '/wishes/new' do 
    if logged_in?
      erb :'wish/new' 
    else  
      erb :failure
    end  
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
    elsif !logged_in?
      erb :not_logged_in
    else
      redirect "/users/#{current_user.id}"
    end
    
  end

  get '/wishes/:id' do 
    erb :'wish/show'
  end  

  patch '/wishes/:id' do 
    if current_user.wishes.include?(current_wish)
      current_wish.update(name: params[:name], details: params[:details]) 
      redirect "/wishes/#{params[:id]}"
    else
      redirect '/'  
    end  
  end
 
  delete '/wishes/:id' do 
    if current_user.wishes.include?(current_wish)
      Wish.find(params[:id]).destroy
      redirect "/users/#{current_user.id}"  
    else
      redirect '/'  
    end  
  end  
  
end
