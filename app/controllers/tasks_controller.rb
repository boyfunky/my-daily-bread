# frozen_string_literal: true

# Task controller
class TasksController < ApplicationController
  before_action :find_task, only: %i[show update destroy]

  def index
    task_list = ActiveModel::Serializer::CollectionSerializer.new(TaskList.call(filter_params, @current_user), each_serializer: TaskSerializer)
    json_success(task_list)
  end

  def create
    task = @current_user.tasks.new(task_params)
    task.save!
    json_success(TaskSerializer.new(task).as_json)
  end

  def show
    json_success(TaskSerializer.new(@task).as_json)
  end

  def update
    @task.update(task_params)
    json_success(TaskSerializer.new(@task).as_json)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :commencement_date)
  end

  def find_task
    binding.pry
    @task = Task.find_by(id: params[:id])
    json_unauthorized('This task does not belong to you') if @task.user != @current_user
    json_not_found('Task does not exist') if @task.nil?
  end

  def filter_params
    params.permit(:title, :status, :commencement_date)
  end
end
