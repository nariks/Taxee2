class UsersController < ApplicationController

	#Route to handle new user signup
  get '/registrations/signup' do
  	erb :'/registrations/signup', :layout => :'home_layout'
  end

  #Route to post user details to User table
  post '/registrations' do
    @user = User.create(:name => params[:name], 
                        :email => params[:email], 
                        :password => params[:password], 
                        :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect '/registrations/signup'
    end

  end

  #Route to render user login form
  get '/sessions/login' do
    erb :'/sessions/login', :layout => :'home_layout'
  end

  #Route to signin valid user
  post '/sessions' do
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params['password'])
      session[:id] = user.id
      redirect 'users/home'
    else
      redirect 'registrations/signup'
    end
  end

  #Route to show signed in user's profile and list all clients created by user.
  get '/sessions/my_profile' do
    puts "Hello"
    if logged_in?
      user = current_user
      @clients = Client.my_clients(current_user) 
      puts @clients
      erb :"users/user_profile"
    else
      redirect '/'
    end
  end

  #Route to show signed in user home page
  get '/users/home' do

    if logged_in?
      @user = current_user
      erb :'users/home', :layout => :'home_layout'
    else
      redirect '/'
    end
  end

#Route to handle user signout
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end
  

  

end

