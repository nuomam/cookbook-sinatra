require 'csv'
require_relative 'recipe'
require_relative 'controller'

class Cookbook
  attr_accessor :recipes

  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    csv_parser
    # @csv_parser = CSV.foreach(csv_file) {|row| @cookbook << row }
  end

  def add_recipe(recipe)
    @recipes << recipe
    csv_writer
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id - 1)
    csv_writer
  end

  def all
    return @recipes
  end

  def find(index)
    return @recipes[index]
  end

  private

  def csv_parser
    CSV.foreach(@csv_file) do |row|
      recipe = Recipe.new(row[0], row[1], row[2], row[3])
      @recipes << recipe
    end
  end

  def csv_writer
    csv_options = { col_sep: ',', force_quotes: true }
    CSV.open(@csv_file, "wb", csv_options) do |csv|
      @recipes.each do |recipe|
        csv.puts([recipe.name, recipe.description, recipe.cooking_time, recipe.difficult])
      end
    end
  end
end
