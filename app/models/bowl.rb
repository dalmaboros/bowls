class Bowl < ActiveRecord::Base
  belongs_to :user
  has_many :bowl_scraps
  has_many :scraps, through: :bowl_scraps

  validates :name, presence: :true, :uniqueness => {scope: :user_id}, length: { maximum: 40 }
  validates :user, presence: :true

  scope :no_scraps, -> { Bowl.includes(:scraps).where( :scraps => { :id => nil } ) }

  def scraps_attributes=(scrap_attributes)
    scrap_attributes.delete_if { |_k, v| v[:description].blank? }
    scrap_attributes.values.each do |scrap_attribute|
      scrap = Scrap.find_or_create_by(scrap_attribute)
      self.scraps << scrap
    end
  end

end
