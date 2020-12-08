ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Opens up a console sandbox."
task :console do
  Pry.start
end