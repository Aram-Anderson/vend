require 'rails_helper'

feature "User visits a specific machine page" do
  scenario 'they see the snacks in that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    snack2 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    snack3 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))

    visit machine_path(dons)

    expect(page).to have_content(snack1.name)
    expect(page).to have_content(snack1.price)
    expect(page).to have_content(snack2.name)
    expect(page).to have_content(snack2.price)
    expect(page).to have_content(snack3.name)
    expect(page).to have_content(snack3.price)
  end
  scenario "they see the average price of all snacks in that machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    snack2 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    snack3 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))

    average = ((snack1.price + snack2.price + snack3.price) / 3).round(2)

    visit machine_path(dons)

    expect(page).to have_content(average)
  end
end
