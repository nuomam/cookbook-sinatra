require 'open-uri'
require 'nokogiri'
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'marmiton'

class Controller
  attr_reader :cookbook

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @parsing = Marmiton.new
  end

  def list
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    name = @view.recipe_name
    description = @view.recipe_description
    cooking_time = @view.recipe_cooking_time
    recipe = Recipe.new(name, description, cooking_time)
    @cookbook.add_recipe(recipe)
    puts "La recette #{name} a bien été créée."
  end

  def destroy
    list
    id = @view.recipe_id_to_delete
    @cookbook.remove_recipe(id)
    puts "La recette a bien été supprimée"
  end

  def import
    # Quel ingredient ?
    ingredient = @view.import_ingredient
    # Pasing on !
    @parsing.search(ingredient)
    # Affichage des recettes parsed
    @view.display_parsed(@parsing.recipe_scarped)
    # Quel id de recette ?
    id = @view.recipe_import
    name = @parsing.recipe_scarped[id - 1][:name]
    description = @parsing.recipe_scarped[id - 1][:description]
    cooking_time = @parsing.recipe_scarped[id - 1][:cooking_time]
    difficult = @parsing.recipe_scarped[id - 1][:difficult]
    # Création de la recette
    recipe = Recipe.new(name, description, cooking_time, difficult)
    @cookbook.add_recipe(recipe)
    # Import de la recette
    puts "La recette a bien été ajoutée à votre livre de recette."
  end

  def done
    #Quelle recette marquer as done ?
    list
    id = @view.recipe_id_done
    recipe = @cookbook.find(id - 1)
    recipe.mark_as_done!
  end
end

