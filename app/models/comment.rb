class Comment < ApplicationRecord
  # === Associations ===
  belongs_to :quote
  
  # === Validations ===
  validates :content, presence: true, length: { minimum: 3, maximum: 500 }
  validates :anonymous_name, length: { maximum: 50 }, allow_blank: true
  
  # === Scopes ===
  scope :recent, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }
  
  # === Callbacks ===
  before_save :generate_anonymous_name, if: -> { anonymous_name.blank? }
  
  # === Instance Methods ===
  def display_name
    anonymous_name.present? ? anonymous_name : "Anonymous ##{id}"
  end
  
  def short_content(limit = 100)
    content.length > limit ? "#{content[0..limit-1]}..." : content
  end
  
  private
  
  def generate_anonymous_name
    # Her quote için sırayla #1, #2, #3 şeklinde isimler oluştur
    count = quote.comments.count + 1
    self.anonymous_name = "##{count}"
  end
end
