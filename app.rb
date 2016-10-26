require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'
require_relative 'marmiton'

set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end
CSV_FILE   = File.join(__dir__, 'recipes.csv')


get '/' do
  erb :index
end

get '/list' do
  @recipes = Cookbook.new(CSV_FILE).all
  erb :list
end

get '/create' do
  erb :create
end

get '/destroy' do
  erb :destroy
end

get '/import' do
  erb :import
end

get '/done' do
  erb :done
end

# get '/scrap' do
#   erb :scrap
# end

post '/recipe' do
  @recipes = Cookbook.new(CSV_FILE)
  recipe = Recipe.new(params[:name],params[:description])
  @recipes.add_recipe(recipe)
  erb :index
end

post '/scrap' do
  @marmiton = Marmiton.new
  @marmiton.search(params[:ingredient])
  @cookbook_parsed = @marmiton.recipe_scarped
  erb :scrap
end

post '/item_import' do
  @recipes = Cookbook.new(CSV_FILE)
  @marmiton = Marmiton.new
  @cookbook_parsed = @marmiton.recipe_scarped
  @id = params[:index].to_i
  name = @cookbook_parsed[@id][:name]
  description = @cookbook_parsed[id][:description]
  recipe = Recipe.new(name, description)
  @recipes.add_recipe(recipe)
  erb :index
end
