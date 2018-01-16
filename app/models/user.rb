class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_destroy :delete_parents

  has_many :jobs
  has_many :projects

  private
  def delete_parents    
    self.jobs.delete_all
    self.projects.delete_all
  end


#  before_logout :empty_session

#  def empty_session
#    reset_session
#  end
end
