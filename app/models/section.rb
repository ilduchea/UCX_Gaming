class Section
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  recursively_embeds_many cascade_callbacks: true
  belongs_to :sectional, polymorphic: true
  embeds_many :traits, cascade_callbacks: true
  accepts_nested_attributes_for :traits


  validates :name, presence: true

  field :name
  field :keep, type: Boolean, default: false
end
