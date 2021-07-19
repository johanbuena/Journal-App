class Task < ApplicationRecord

    belongs_to :journal
    belongs_to :user

    validates :taskname, 
                presence: true,
                length: {maximum: 20}

    validates :taskdescription, 
                presence: true,
                length: { within: 10..100 }

    validate :taskdeadline_cannot_be_in_the_past

    validates :taskdeadline, 
                presence: true
    
    private

    def taskdeadline_cannot_be_in_the_past
        return if (taskdeadline.nil? or taskdeadline.today?)
        if self.new_record?   
            return errors.add(:task_deadline, "can't be in the past") if (taskdeadline.present? && taskdeadline < Date.today)
        end

        unless self.new_record?
            return if self.taskdeadline_changed? == false

            return errors.add(:task_deadline, "can't be in the past") if taskdeadline.past?
        end
    end
end