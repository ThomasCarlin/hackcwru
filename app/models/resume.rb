class Resume < ActiveRecord::Base
	has_many :information
	has_many :objective
	has_many :work
	has_many :education
	accepts_nested_attributes_for :information
	validates :title, presence: true, length: { maximum:  20}
end
