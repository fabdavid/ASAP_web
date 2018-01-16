class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  helper_method :admin?, :authorized?, :read_only?, :readable?
  before_action :init_session

  def admin?
    current_user and ['bbcf.epfl@gmail.com', 'samer.bekhazi@gmail.com'].include?(current_user.email)
  end

  def authorized?
    (current_user and @project and current_user.id == @project.user_id) or (@project and @project.sandbox == true and session[:sandbox] == @project.key) or admin?
  end

  def read_only? p
     (!current_user and p.sandbox != true) or (current_user and p.user_id != current_user.id and !admin?) or (current_user and share =  p.shares.select{|u| u.id == current_user.id}.first and share.write_access == false)
  end

  def readable? p
    admin? or (p and ((!current_user and (p.sandbox == true and session[:sandbox] == p.key)) or p.public == true or (current_user and p.user_id == current_user.id) or (current_user and share = p.shares.select{|u| u.id == current_user.id}.first and share.read_access == true)))
  end

  def create_key
    tmp_key = Array.new(6){[*'0'..'9', *'a'..'z'].sample}.join
    while Project.where(:key => tmp_key).count > 0
      tmp_key = Array.new(6){[*'0'..'9', *'a'..'z'].sample}.join
    end
    return tmp_key
  end


  def init_session
    session[:sandbox]||=create_key()   
    session[:settings]||={:limit => 5, :public_limit => 5, :free_text => '', :public_free_text => ''}
  end

  #def create_job(o, step_id, project, job_id_key, speed_id = 1)
  #  h = {:project_id => project.id, :step_id => step_id,  :status_id => 1, :speed_id => speed_id}
  #  job = Job.new(h)
  #  o.update_attributes({job_id_key => job.id, :status_id => 1})
  #end

  
end
