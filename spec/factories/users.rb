# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  provider            :string(255)      default("email"), not null
#  uid                 :string(255)      default(""), not null
#  encrypted_password  :string(255)      default(""), not null
#  remember_created_at :datetime
#  name                :string(255)
#  email               :string(255)
#  tokens              :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { 'Jan' }
    email { 'jan@kowalski.pl' }
    password { 'haslo' }
  end
end
