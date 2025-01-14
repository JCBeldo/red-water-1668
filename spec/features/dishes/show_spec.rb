require 'rails_helper'

RSpec.describe 'Dish show page' do
  let!(:gorden) { Chef.create!(name: 'Gorden Ramsey') }
  let!(:dish_1) { gorden.dishes.create!(name: 'Tofu Stirfry', description: "Tofu and veggies wok tossed and lightly seasoned with soy sauce" ) }
  let!(:ingredient_1) { Ingredient.create!(name: 'Tofu', calories: "50" ) }
  let!(:ingredient_2) { Ingredient.create!(name: 'Bell Pepper', calories: "20" ) }
  let!(:ingredient_3) { Ingredient.create!(name: 'Onion', calories: "15" ) }
  let!(:dish_ingredients_1) { DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_1.id) }
  let!(:dish_ingredients_2) { DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_2.id) }
  let!(:dish_ingredients_3) { DishIngredient.create!(dish_id: dish_1.id, ingredient_id: ingredient_3.id) }

  describe 'Dishes attributes and chef who made it' do
    it 'should display the dishes name and description' do
      visit dish_path(dish_1)

      expect(page).to have_content(dish_1.name)
      expect(page).to have_content(dish_1.description)
    end
    it 'should display the list of ingredients for the dishes and a total calorie count' do
      visit dish_path(dish_1)
      
      expect(page).to have_content(ingredient_1.name)
      expect(page).to have_content(ingredient_1.calories.to_i)
      expect(page).to have_content(ingredient_2.calories.to_i)
    end
    it 'should display the name of the chef who made the dish' do
      visit dish_path(dish_1)

      expect(page).to have_content("Gorden Ramsey")
    end
  end

  describe 'Form to add ingredients' do
    it 'should display a form to add exisiting ingredients' do
      visit dish_path(dish_1)
      save_and_open_page
      expect(page).to have_button("Add My Ingredient")
      expect(page).to have_field(:id)
      
      fill_in :id, with: 3
      click_button "Add My Ingredient"

      expect(current_path).to eq(visit dish_path(dish_1))
      expect(page).to have_content(ingredient_3.name)
    end
  end
end