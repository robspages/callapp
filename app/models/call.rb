class Call < ApplicationRecord
  belongs_to :callers
  has_man :recordings 
end
