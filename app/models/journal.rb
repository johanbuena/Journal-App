class Journal < ApplicationRecord
    belongs_to :user
    has_many :tasks

    validates :journal_name,
                presence: true,
                length: {maximum: 20}
                
    validates :journal_description, 
                presence: true,
                length: { within: 10..100 }
end
