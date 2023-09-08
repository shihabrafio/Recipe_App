require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123') }

  it 'is valid with valid attributes' do
    recipe = user.recipes.build(name: 'Test Recipe')
    expect(recipe).to be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it 'has many recipe foods' do
    association = described_class.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq :has_many
  end

  it 'has many foods through recipe foods' do
    association = described_class.reflect_on_association(:foods)
    expect(association.macro).to eq :has_many
    expect(association.options[:through]).to eq :recipe_foods
  end
  it 'calculates missing foods correctly' do
    # Create a recipe
    recipe = user.recipes.create(name: 'Test Recipe')

    # Create some food items
    food1 = Food.create(name: 'Ingredient 1', price: 5, quantity: 10)
    food2 = Food.create(name: 'Ingredient 2', price: 3, quantity: 2)
    Food.create(name: 'Ingredient 3', price: 2, quantity: 7)

    # Create RecipeFood records associated with the recipe
    recipe.recipe_foods.create(food: food1, quantity: 3)
    recipe.recipe_foods.create(food: food2, quantity: 5)

    # Calculate missing foods
    missing_foods = recipe.missing_foods

    # Expectations:
    # Ingredient 1: Required 3, Available 10 (No missing)
    # Ingredient 2: Required 5, Available 2 (Missing)
    # Ingredient 3: Not in the recipe (Not missing)
    expect(missing_foods[:list]).to include(food2)
    expect(missing_foods[:count]).to eq(1)
    expect(missing_foods[:total_price]).to eq(3) # Total price based on missing foods
  end
end
