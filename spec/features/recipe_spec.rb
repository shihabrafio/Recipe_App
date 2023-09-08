require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET #index' do
    it 'renders the index page when the user is authenticated' do
      user = User.create(email: 'user@example.com', password: 'password')
      sign_in user

      get recipes_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'redirects to the login page when the user is not authenticated' do
      get recipes_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #new' do
    it 'renders the new page when the user is authenticated' do
      user = User.create(email: 'user@example.com', password: 'password')
      sign_in user

      get new_recipe_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end

    it 'redirects to the login page when the user is not authenticated' do
      get new_recipe_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe when the user is authenticated' do
      user = User.create(email: 'user@example.com', password: 'password')
      sign_in user

      expect do
        post recipes_path, params: { recipe: { name: 'New Recipe', user_id: user.id } }
      end.to change(Recipe, :count).by(1)

      expect(response).to have_http_status(302) # Redirect after successful creation
      expect(response).to redirect_to(recipes_path)
      expect(flash[:success]).to eq('Recipe added successfully')
    end
    it 'fails to create a new recipe with invalid data when the user is authenticated' do
      user = User.create(email: 'user@example.com', password: 'password')
      sign_in user

      expect do
        post recipes_path, params: { recipe: { name: '', user_id: user.id } }
      end.not_to change(Recipe, :count)

      expect(response).to have_http_status(200) # Expecting a re-render of the :new template
      expect(response).to render_template(:new)
      expect(flash[:error]).to eq('Recipe not added')
    end

    it 'redirects to the login page when the user is not authenticated' do
      post recipes_path, params: { recipe: { name: 'New Recipe' } }

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
