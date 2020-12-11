

class WishController < ApplicationController
  get '/wishes/new' do 
    if !logged_in?
      erb :failure
    end
    erb :'wish/new'  
  end  

  post '/wishes' do          
    wish = Wish.create(name: params[:name].strip)
    if !wish.valid?
      #display errors with either rack-flash or active record error messages
      redirect '/wishes/new'
    end  
    if params[:comment] != ""
      comment = Comment.create(content: params[:comment], user_id: current_user.id, wish_id: wish.id) 
    end  
    current_user.wishes << wish 
    redirect "/wishes/#{wish.id}"
  end

  get '/wishes/:id/edit' do
    if current_user.wishes.include?(current_wish)
      erb :'wish/edit'
    else
      erb :failure
    end
    
  end

  get '/wishes/:id' do 
    erb :'wish/show'
  end  

  patch '/wishes/:id' do 
    if params[:comment] != ""
      comment = current_wish.comments.first
      comment.update(content: params[:comment])
    end  
    current_wish.update(name: params[:name])
    redirect "/wishes/#{params[:id]}"
  end
 
  delete '/wishes/:id' do 
    Wish.find(params[:id]).destroy
    redirect "/users/#{current_user.id}"  
  end  
  
end
