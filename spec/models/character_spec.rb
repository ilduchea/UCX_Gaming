require 'rails_helper'

RSpec.describe Character, type: :model do
  # it { should belong_to :user }
  it { should belong_to :game_system }
  it { should have_many :sections }
  it { should validate_presence_of :sheet_name }
  it { should have_field :char_sheet }
end
