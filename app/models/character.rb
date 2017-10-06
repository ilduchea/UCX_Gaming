class Character
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  belongs_to :game_system
  # belongs_to :user, validation: false
  has_many :sections, as: :sectional, validate: false

  validates :name, presence: true

  field :name
  field :player_name

  def child_check section
    section.child_sections.each do |child_section|
      child_section._id = BSON::ObjectId.new
      child_section.traits.each do |trait|
        trait._id = BSON::ObjectId.new
      end
      child_check child_section
    end
  end

  def self.set_new_char cs
    char = Character.new(cs.attributes)
    char.created_at = nil
    char.updated_at = nil
    char.char_sheet = false
    char._id = BSON::ObjectId.new
    char.sections.each do |section|
      unless section.keep
        section._id = BSON::ObjectId.new
        section.traits.each do |trait|
          trait._id = BSON::ObjectId.new
        end
        child_check section
      end
    end
    char.save
  end
end
