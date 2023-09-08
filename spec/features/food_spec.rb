require 'rails_helper'

RSpec.describe 'Food', type: :feature do
  let(:user) { User.create(email: 'user@example.com', password: 'password123') }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET #index' do
    it 'displays the list of foods' do
      Food.create(name: 'Test Food', measurement_unit: 'Unit', price: 10, quantity: 5, user_id: user.id)

      visit food_index_path
      expect(page).to have_content('Test Food')
      expect(page).to have_content('Unit')
      expect(page).to have_content('10')
      expect(page).to have_content('5')
    end
  end

  describe 'GET #new' do
    it 'renders the new food form' do
      visit new_food_path
      expect(page).to have_content('Add a New Food')
      expect(page).to have_field('food_name')
      expect(page).to have_field('food_measurement_unit')
      expect(page).to have_field('food_price')
      expect(page).to have_field('food_quantity')
    end
  end
  describe 'POST #create' do
    context 'with valid data' do
      it 'creates a new food and redirects to the food index page' do
        visit new_food_path
        fill_in 'food_name', with: 'Test Food'
        fill_in 'food_measurement_unit', with: 'Unit'
        fill_in 'food_price', with: 10
        fill_in 'food_quantity', with: 5
        click_button 'Add Food'

        expect(page).to have_content('The food has been added successfully')
        expect(current_path).to eq(food_index_path)

        new_food = Food.find_by(name: 'Test Food')
        expect(new_food).to_not be_nil
      end
    end
  end
  describe 'DELETE #destroy' do
    it 'deletes a food' do
      food = Food.create(name: 'Test Food', measurement_unit: 'Unit', price: 10, quantity: 5, user: user)
      visit food_index_path
      click_link 'Delete'
      expect(page).to have_content('The food has been deleted successfully')
    end
  end
end
