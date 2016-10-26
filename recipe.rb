class Recipe
  attr_reader :name, :description, :cooking_time, :difficult

  def initialize(name, description, cooking_time = 0, difficult = "Inconnue")
    @name = name
    @description = description
    @cooking_time = cooking_time
    @difficult = difficult
    @done = false
  end

  def mark_as_done!
    @done = true
  end

  def done?
    return @done
  end
end



