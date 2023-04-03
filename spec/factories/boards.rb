# In spec/factories/boards.rb

FactoryBot.define do
    factory :board do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      rows { 10 }
      columns { 10 }
      mines { 5 }
      # Example of adding custom data to board field
      trait :with_data do
        after(:build) do |board|
          board.board = [
            [{ 'mine' => true, 'adjacent_mines' => 0, 'revealed' => false }, { 'mine' => false, 'adjacent_mines' => 1, 'revealed' => false }, { 'mine' => false, 'adjacent_mines' => 0, 'revealed' => false }],
            [{ 'mine' => false, 'adjacent_mines' => 1, 'revealed' => false }, { 'mine' => false, 'adjacent_mines' => 1, 'revealed' => false }, { 'mine' => false, 'adjacent_mines' => 0, 'revealed' => false }],
            [{ 'mine' => true, 'adjacent_mines' => 1, 'revealed' => false }, { 'mine' => true, 'adjacent_mines' => 1, 'revealed' => false }, { 'mine' => false, 'adjacent_mines' => 0, 'revealed' => false }]
          ]
        end
      end
    end
  end
  