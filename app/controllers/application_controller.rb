require './config/environment'

class ApplicationController < Sinatra::Base

  get('/') {"Hello and Welcome!!!"}

end