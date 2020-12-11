

class WishController < ApplicationController
  get '/wishes/new' do 
    if !logged_in?
      redirect "/failure"
    end
    erb :'wish/new'  
  end  

  post '/wishes' do           ##Create and Associate Comment with Wish and User
    wish = Wish.create(name: params[:name].strip)
    if !wish
      #display errors with either rack-flash or active record error messages
      redirect '/wishes/new'
    end  
    ##Is there a better way to do this?
    wish.comments << Comment.create(content: params[:comments]) if params[:comments]
    current_user.wishes << wish
    current_user.comment_ids << wish.comment_ids.last
    binding.pry  ##Show wishes comments in show page
    redirect "/wishes/#{wish.id}"
  end

  get '/wishes/:id/edit' do
    erb :'wish/edit'
  end

  get '/wishes/:id' do 
    erb :'wish/show'
  end  

  patch '/wishes/:id' do 
    current_wish.update(name: params[:name])
    redirect "/wishes/#{params[:id]}"
  end
 
  delete '/wishes/:id' do 
    Wish.find(params[:id]).destroy
    redirect "/users/#{current_user.id}"  
  end  
  
end
  