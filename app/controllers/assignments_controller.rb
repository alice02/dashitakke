class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show]

  def index
    @assignments = current_user.assignments
  end

  def show
  end

  private
    def set_assignment
      begin
        @assignment = Assignment.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: '無効なURLです。'
      end
    end
end
