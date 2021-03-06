class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all.uniq
  end

  def self.longest
    joins(:boats).order("boats.length").reverse_order.limit(2)
  end
end
