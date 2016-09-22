class Campaign < ApplicationRecord
  has_many :rewards, dependent: :destroy

  # this gives us the possibility of creating rewards at the same time we create
  # the campaign. By passing a special key callad: rewards_attributes
  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true, uniqueness: true

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :canceled
    state :goal_met
    state :goal_unmet

    event :publish do
      transitions from: :draft, to: :published
    end

    event :succeed do
      transitions from: :published, to: :goal_met
    end

    event :fail do
      transitions from: :published, to: :goal_unmet
    end

    event :cancel do
      transitions from: [:published, :goal_met], to: :canceled
    end

    event :raise_goal do
      transitions from: :goal_met, to: :published
    end
  end

  def titleized_title
    title.titleize
  end
end
