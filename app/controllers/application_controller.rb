class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      @user = current_user
      erb :'users/home', :layout => :'home_layout'
    else
      erb :home, :layout => :'home_layout'
    end
  end

  get '/contact' do
    erb :contact

  end

  helpers do
    def logged_in?
      session[:id]
    end
 
    def current_user
      User.find(session[:id])
    end
  end
  
end
