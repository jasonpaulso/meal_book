ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'sinatra/flash'

task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end

