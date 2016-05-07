require './app/controllers/application_controller'

class ClientsController < ApplicationController

  get '/sessions/new_client' do
    if logged_in?
      @user = current_user
      puts current_user.id
      erb :'users/new_client'
    else
      redirect :'/'
    end

  end

  post '/sessions/new_client/?' do

    @client = Client.create(:client_id => params[:client_id],
                            :client_name => params[:client_name],
                            :grp_status => params[:grp_status],
                            :grp_members => params[:grp_members],
                            :user_id => current_user.id
                            )

    if @client.save
      session[:client_id] = @client.client_id
      if@client.grp_members > 0
        erb :'/users/grp_details', :locals => {id: @client.client_id}
      else 
        erb :'users/wages', :locals => {id: @client.client_id}
      end
    else
      # flash[:error] = "Client already exists"
      erb :'users/new_client'
    end                                                                

  end

  # get '/sessions/wages/' do
  #   erb :'users/wages'
  # end



  get '/client/edit/:id' do
    @client = Client.find_by(:client_id => params[:id])
    @wages = Wage.where(:client_id => params[:id])
    erb :'users/client_edit'

  end

  post '/client/edit/:id' do
    client = Client.find_by(:client_id => params[:id])
    
    if client.update_attributes(:client_name => params[:client_name],
                     :grp_status => params[:grp_status],
                     :grp_members => params[:grp_members]
                    )

    
      # session[:client_id] = @client.client_id
      if client.grp_members > 0
        redirect  "/client/edit/grp_details/#{client.client_id}"
      else 
        redirect "client/edit/#{client.client_id}"
      end
    else
      # flash[:error] = "Client already exists"
      erb :'users/new_client'
    end                               
  end

  get '/client/edit/grp_details/:id' do
    
  end

  post '/client/edit/grp_details/:id' do
    

  end

  

  get '/client/delete/:id' do
    Client.destroy_client_record(params[:id])
    redirect '/sessions/my_profile'

  end

  get '/client/export' do
    erb :'users/client_export'
  end

  post '/client/export' do
    Client.retrieve(params[:id])


  end


end
