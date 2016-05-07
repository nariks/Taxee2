require './config/environment'


use UsersController
use ClientsController
use WagesController



use Rack::MethodOverride

run ApplicationController

