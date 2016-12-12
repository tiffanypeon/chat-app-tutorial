class Group < ApplicationRecord
  has_one :owner, foreign_key: :owner_id, class_name: User
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :messages, dependent: :destroy

  def self.get(member_id)
    membership = Group
    return membership if membership.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end
end
