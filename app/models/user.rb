class User < ApplicationRecord
  # === Associations ===
  has_many :quotes, dependent: :destroy
  
  # === Validations ===
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :linkedin_url, length: { maximum: 500 }, allow_blank: true
  validates :linkedin_url, format: { 
    with: /\Ahttps?:\/\/(www\.)?linkedin\.com\/in\/[\w\-]+\/?\z/, 
    message: "must be a valid LinkedIn profile URL" 
  }, allow_blank: true
  
  # === Instance Methods ===
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end
  
  def to_s
    full_name
  end
end
