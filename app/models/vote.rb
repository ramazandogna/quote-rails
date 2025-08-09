class Vote < ApplicationRecord
  # === Associations ===
  belongs_to :quote
  
  # === Validations ===
  validates :vote_type, presence: true, inclusion: { in: %w[like dislike] }
  validates :ip_address, presence: true, format: { 
    with: /\A(?:\d{1,3}\.){3}\d{1,3}\z|(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}\z/,
    message: "must be a valid IP address"
  }
  validates :quote_id, uniqueness: { 
    scope: :ip_address, 
    message: "You can only vote once per quote" 
  }
  
  # === Scopes ===
  scope :likes, -> { where(vote_type: 'like') }
  scope :dislikes, -> { where(vote_type: 'dislike') }
  scope :recent, -> { order(created_at: :desc) }
  
  # === Callbacks ===
  after_create :update_quote_counters
  after_update :update_quote_counters
  after_destroy :update_quote_counters
  
  # === Instance Methods ===
  def like?
    vote_type == 'like'
  end
  
  def dislike?
    vote_type == 'dislike'
  end
  
  private
  
  def update_quote_counters
    quote.update_columns(
      likes_count: quote.votes.likes.count,
      dislikes_count: quote.votes.dislikes.count
    )
  end
end
