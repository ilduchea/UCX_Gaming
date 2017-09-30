class GameSystem
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :characters
  has_many :sections, as: :sectional, validate: false
  accepts_nested_attributes_for :sections

  validates :name, :publisher, presence: true

  field :name
  field :publisher
  field :description

end
