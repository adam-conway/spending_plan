require 'rails_helper'

describe "User creates a new charge" do
  scenario "a user can create a new charge from index page" do
    user = User.create!(username: "Adam", password: "password")
    budget = user.budgets.create!(name: "Denver")
    category = budget.categories.create!(title: "Rent")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_budget_charges_path(user, budget)

    fill_in "charge[date]", with: "1991-08-28"
    fill_in "charge[payee]", with: "Jake"
    fill_in "charge[notes]", with: "Horrible purchase"
    fill_in "charge[amount]", with: 20
    select('Rent', from: 'charge[id]')
    click_button "Create"

    expect(current_path).to eq(user_budget_charges_path(user, budget))
    expect(page).to have_content("Jake")
    expect(Charge.count).to eq(1)
  end
  scenario "a user can create a new charge from new page" do
    user = User.create!(username: "Adam", password: "password")
    budget = user.budgets.create!(name: "Denver")
    category1 = budget.categories.create!(title: "Rent")
    category2 = budget.categories.create!(title: "Food")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_user_budget_charge_path(user, budget)

    fill_in "charge[date]", with: "1991-08-28"
    fill_in "charge[payee]", with: "Adam"
    fill_in "charge[notes]", with: "Horrible purchase"
    fill_in "charge[amount]", with: 20
    fill_in "adjustments[#{category1.id}][amount]", with: -5
    fill_in "adjustments[#{category2.id}][amount]", with: -15

    click_button "Create"

    expect(current_path).to eq(user_budget_charges_path(user, budget))
    expect(page).to have_content("Adam")
    expect(page).to have_content("Rent (-$5.00)")
    expect(page).to have_content("Food (-$15.00)")
    expect(Charge.count).to eq(1)
  end
end
