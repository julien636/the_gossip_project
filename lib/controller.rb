require 'gossip'
require 'user'
class ApplicationController < Sinatra::Base


  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @user=User.new(params['user_account'],params['user_password'])
    redirect "/signin"
   end

  get '/signin' do
    erb :signin 
  end

  post '/signin' do
    if params['user_account']==User.finduser && params['user_password']==User.findpassword
    then redirect "/"
    else
      redirect "/signin"
    end
   end

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  post '/' do
   redirect "/gossips/#{params['index']}"

  end
  

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"],"").save
    redirect '/'
  end
  

  get '/gossips/:index' do
    erb :show_gossip, locals: {gossips: Gossip.find(params['index'].to_i), index: params['index'], user:User.finduser}
  end

  post '/gossips/:index' do
    Gossip.edit_comment(params['index'].to_i,params['gossip_comment'])
    redirect '/'
  end



  get '/gossips/:index/edit' do
    erb :edit, locals: {gossips: Gossip.find(params['index'].to_i), index: params['index']}
  end

  post '/gossips/:index/edit' do
    Gossip.edit_gossip(params['index'].to_i,params["gossip_content_edit"])
    redirect "/"
 
   end
end