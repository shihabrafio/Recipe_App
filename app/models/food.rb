class Food < ApplicationRecord
  belongs_to :user

  attr_accessor :measurement_unit
end
