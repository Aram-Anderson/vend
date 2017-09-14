require 'rails_helper'

feature "When I visit a specific snack page" do
  scenario "I see the name of that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))

    visit snack_path(snack1)

    expect(page).to have_content(snack1.name)
  end
  scenario "I see the price for that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))

    visit snack_path(snack1)

    expect(page).to have_content(snack1.price)
  end
  scenario "I see a list of locations with vending machines that carry that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    lancer  = owner.machines.create(location: "The Lancer Lounge")
    snack1 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    lancer.snacks << snack1

    visit snack_path(snack1)

    expect(page).to have_content(dons.location)
    expect(page).to have_content(lancer.location)
  end
  scenario "I see the average price for snacks in those vending machines" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    lancer  = owner.machines.create(location: "The Lancer Lounge")
    snack1 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    snack2 = lancer.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    lancer.snacks << snack1
    average = ((snack1.price + snack2.price) / 2).round(2)

        visit snack_path(snack1)

    expect(page).to have_content(average)
  end
  scenario "And I see a count of the different kinds of items in that vending machine." do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    lancer  = owner.machines.create(location: "The Lancer Lounge")
    snack1 = dons.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    snack2 = lancer.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    snack3 = lancer.snacks.create(name: Faker::Food.dish, price: Faker::Number.decimal(2))
    lancer.snacks << snack1

        visit snack_path(snack1)

    expect(page).to have_content("There is 1 #{snack1.name} at #{lancer.location}")
  end
end
