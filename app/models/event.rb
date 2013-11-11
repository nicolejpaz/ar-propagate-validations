class Event < ActiveRecord::Base
  validates_presence_of :date, message: "Please select a date"
  validate :validate_validity_of_date
  validate :date_cannot_be_in_the_past
  validates_uniqueness_of :title, message: "The title has already been taken"
  validates_presence_of :title, message: "A title is required"
  validates_presence_of :organizer_name, message: "An organizer name is required"
  validate :validate_email

  def date_cannot_be_in_the_past
    unless date.nil?
      if date < Date.today
        errors.add(:date, "The date can't be in the past")
      end
    end
  end

  def validate_validity_of_date
    unless date.nil?
      year = date.year
      month = date.month
      day = date.day
      if date != Date.civil(year, month, day)
        errors.add(:date, "The date is invalid")
      end
    end
  end

  def validate_email
    unless organizer_email.match("/\S{2,}@{1}\S{2,}.{1}\S{2,}/")
      errors.add(:organizer_email, "The email is invalid")
    end
  end
end
