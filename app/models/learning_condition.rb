class LearningCondition < ActiveRecord::Base
  belongs_to :cohort
  # belongs_to :klass # for convenience
  
  attr_accessible #:klass_id
  
  def notify_student_exercise_event(student_exercise, event) # event is an enum
    # Events:
    #    first viewed the feedback
    #    finished the problem
    #    finished the assignment
    #    --- how do we check for the assignment being due
    
  end

  def notify_student_assignment_event(student_assignment, event)
    # Need cron job that periodically checks to see which assignments 
    # have come due (that haven't been noticed before -- by checking
    # the observed event table).  For those assignments, get the 
    # student assignments and call this method (under the covers
    # this should set the feedback window times on all student 
    # exercises (or just on the student assignment?) and then schedule
    # an email to each student that tells them the feedback is available)
  end

  
  
  #############################################################################
  # Access control methods
  #############################################################################

  def can_be_read_by?(user)
    can_anything?(user)
  end

  def can_be_created_by?(user)
    can_anything?(user)
  end

  def can_be_updated_by?(user)
    can_anything?(user)
  end

  def can_be_destroyed_by?(user)
    can_anything?(user)
  end
  
  def can_anything?(user)
    # If the class is not the subject of formal research, a learning
    # condition is still necessary and needs to be available to the
    # instructors
    
    cohort.klass.is_controlled_experiment ? 
      Researcher.is_one?(user) || user.is_administrator? :
      cohort.klass.is_instructor(user) || user.is_administrator?
  end
end