require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  it 'is valid with valid attributes' do
    recipe = Recipe.create(name: 'Test Recipe')
    food = Food.create(name: 'Ingredient 1', price: 5, quantity: 10)

    recipe_food = RecipeFood.new(recipe:, food:, quantity: 5)
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a recipe' do
    food = Food.create(name: 'Ingredient 1', price: 5, quantity: 10)

    recipe_food = RecipeFood.new(food:, quantity: 5)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without a food' do
    recipe = Recipe.create(name: 'Test Recipe')

    recipe_food = RecipeFood.new(recipe:, quantity: 5)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without a quantity' do
    recipe = Recipe.create(name: 'Test Recipe')
    food = Food.create(name: 'Ingredient 1', price: 5, quantity: 10)

    recipe_food = RecipeFood.new(recipe:, food:, quantity: nil)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid with a negative quantity' do
    recipe = Recipe.create(name: 'Test Recipe')
    food = Food.create(name: 'Ingredient 1', price: 5, quantity: 10)

    recipe_food = RecipeFood.new(recipe:, food:, quantity: -1)
    expect(recipe_food).not_to be_valid
  end
end
