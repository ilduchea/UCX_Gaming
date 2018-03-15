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
    end
  end

  def self.set_new_char gs
    char = Character.new
    gs.sections.each do |section|
      unless section.keep
        section._id = BSON::ObjectId.new
        section.sectional_type = ''
        section.sectional_id = ''
        section.traits.each do |trait|
          trait._id = BSON::ObjectId.new
        end
        section.child_sections.each do |child_section|
          child_section._id = BSON::ObjectId.new
          child_section.traits.each do |trait|
            trait._id = BSON::ObjectId.new
          end
        end
        char.sections.push(section)
      end
    end
    char
  end
end
