class Car < ApplicationRecord
  belongs_to :make
  belongs_to :model
  belongs_to :trim
  belongs_to :style

  validates :colour, :year, :make, :model, :trim, :style, presence: true

  def description
    "#{make.make} #{model.model} #{style.body_style} #{trim.trim_level} #{year}".gsub('  ', ' ')
  end
end
