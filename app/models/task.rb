class Task < ApplicationRecord
  # belongs_to :user
  validates:task,       presence: true
  validates:limit_date, presence: true
  validates:state,      presence: true
  validates:user_id,    presence: true, numericality: { only_integer: true, greater_than: 0 }
end
