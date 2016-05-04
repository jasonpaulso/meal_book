
class IngredientsController < ApplicationController

get '/ingredients/:id' do
  @ingredient = Ingredient.find(params[:id])
  erb :"/ingredients/index"
end
  
end