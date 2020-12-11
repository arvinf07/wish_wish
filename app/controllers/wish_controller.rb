

class WishController < ApplicationController
  get '/wishes/new' do 
    if !logged_in?
      redirect "/failure"
    end
    erb :'wish/new'  
  end  

  post '/wishes' do          
    wish = Wish.create(name: params[:name].strip, user)
    if !wish.valid?
      #display errors with either rack-flash or active record error messages
      redirect '/wishes/new'
    end  
    ##Is there a better way to do this?
    if params[:comment] != ""
      comment = Comment.create(content: params[:comment], user_id: current_user.id, wish_id: wish.id) 
    end  
    current_user.wishes << wish  #why is it not saving to the user comments
    redirect "/wishes/#{wish.id}"
  end

  get '/wishes/:id/edit' do
    erb :'wish/edit'
  end

  get '/wishes/:id' do 
    erb :'wish/show'
  end  

  patch '/wishes/:id' do 
    if params[:comment]
      comment = Comment.create(content: params[:comment]) 
      current_wish.comments <<  comment
      current_user.comments << comment
      binding.pry
    end  
    current_wish.update(name: params[:name])
    redirect "/wishes/#{params[:id]}"
  end
 
  delete '/wishes/:id' do 
    Wish.find(params[:id]).destroy
    redirect "/users/#{current_user.id}"  
  end  
  
end
  