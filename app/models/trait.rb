class Trait
  include Mongoid::Document

  embedded_in :section

  validates :name, presence: true

  field :name
end
