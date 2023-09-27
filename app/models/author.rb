# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  genre      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Author < ApplicationRecord

  has_many :books

  validates :first_name, presence: true, length: { maximum: 32 }
  validates :last_name, presence: true, length: { maximum: 32 }
  validates :genre, allow_blank: true, inclusion: { in: Proc.new { genre_list } }

  def self.genre_list
    %w( fantasy sf drama )
  end

end
