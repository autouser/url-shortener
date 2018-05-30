class Link < ApplicationRecord
  validates :url,
            format: { with: %r{\Ahttps?:\/\/[^\n]+\z}i },
            length: { maximum: 255 }

  after_create :generate_token

  private

  def generate_token
    update(token: id.to_s(36))
  end
end
