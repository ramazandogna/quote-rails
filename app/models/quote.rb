class Quote < ApplicationRecord
  # === Associations ===
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  # === Validations ===
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :quote_type, presence: true, inclusion: { in: %w[joke inspiring] }
  validates :views_count, :likes_count, :dislikes_count, numericality: { greater_than_or_equal_to: 0 }
  
  # === Scopes ===
  scope :jokes, -> { where(quote_type: 'joke') }
  scope :inspiring, -> { where(quote_type: 'inspiring') }
  scope :recent, -> { order(created_at: :desc) }
  scope :popular, -> { order(likes_count: :desc) }
  scope :random_order, -> { order(Arel.sql('RANDOM()')) }
  
  # === Callbacks ===
  after_create :reset_counters
  
  # === Instance Methods ===
  def joke?
    quote_type == 'joke'
  end
  
  def inspiring?
    quote_type == 'inspiring'
  end
  
  def increment_views!
    increment!(:views_count)
  end
  
  def total_votes
    likes_count + dislikes_count
  end
  
  def vote_ratio
    return 0 if total_votes.zero?
    (likes_count.to_f / total_votes * 100).round(1)
  end
  
  def short_content(limit = 100)
    content.length > limit ? "#{content[0..limit-1]}..." : content
  end
  
  private
  
  def reset_counters
    self.update_columns(
      views_count: 0,
      likes_count: 0, 
      dislikes_count: 0
    )
  end
end
