class Review < ApplicationRecord

    belongs_to :customer
    belongs_to :spot

    scope :reviewed_today, -> { where(created_at: Time.current.at_beginning_of_day..Time.current.at_end_of_day) }

    validates :all_rating, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

    # validates :comment, length: { minimum: 1 }


def get_spot_image(width, height)
    unless spot_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
        spot_image.variant(resize_to_limit: [width, height]).processed
    end
end
