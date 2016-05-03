require './config/environment'

use Rack::MethodOverride
use UsersController
use MealsController
use IngredientsController
run ApplicationController