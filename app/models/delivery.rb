# == Schema Information
#
# Table name: deliveries
#
#  id                    :integer          not null, primary key
#  description           :string
#  details               :string
#  status                :string           default("waiting")
#  supposed_arrival_date :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#
class Delivery < ApplicationRecord
  validates(:description, presence:true)
  validates(:supposed_arrival_date, presence: true)
  belongs_to(:user)
end
