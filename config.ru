require './config/environment'
require 'sinatra/activerecord/rake'
require 'sinatra/flash'

use Rack::MethodOverride
use UsersController
use MealsController
use IngredientsController
run ApplicationController