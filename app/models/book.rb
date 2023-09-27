# == Schema Information
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  title      :string
#  cover      :string
#  data       :jsonb
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Book < ApplicationRecord
  mount_uploader :cover, CoverUploader

  belongs_to :author

  validates :title, presence: true, length: { maximum: 128 }
  validates :cover, presence: true

  def cover_filename
    cover.file.original_filename
  end

  def cover_path
    cover.path
  end

end
