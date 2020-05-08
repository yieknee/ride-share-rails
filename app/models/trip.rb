class Trip < ApplicationRecord
  belongs_to :drivers
  belongs_to :passengers
end
