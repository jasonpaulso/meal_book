
class MealsController < ApplicationController

  get('/meals/new') {erb :"/meals/new"}
  get('/meals/index'){erb :'/meals/index'}  
  
end