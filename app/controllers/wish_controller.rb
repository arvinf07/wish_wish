

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
    @wish = Wish.find(params[:id])
    erb :'wish/edit'
  end

  get '/wishes/:id' do 
    @wish = Wish.find(params[:id])
    erb :'wish/show'
  end  
  
  
end
  