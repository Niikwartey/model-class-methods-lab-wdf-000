class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where("classifications.name is 'Catamaran'")
  end

  def self.sailors
    joins(boats: :classifications).where("classifications.name is 'Sailboat'").distinct
  end

  def self.motorboats
    joins(boats: :classifications).where("classifications.name is 'Motorboat'").distinct
  end

  def self.talented_seamen
    # joins(boats: :classifications).where(classifications: {name: ['Motorboat', 'Sailboat']}).distinct
    where("id IN (?)", sailors.pluck(:id) & motorboats.pluck(:id)).distinct
  end

  def self.non_sailors
    where("id NOT IN (?)", sailors.pluck(:id)).distinct
  end
end
