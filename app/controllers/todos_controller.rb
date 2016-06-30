class TodosController < ApplicationController

  def index
    confirm = JsonWebToken.verify(params[:jwt], key: ENV['SECRET'])
    render json: Todo.where(user_id: confirm[:ok][:id])
    rescue
      render json: {'error': 'invalid JWT'}
  end

  def create
    confirm = JsonWebToken.verify(params[:jwt], key: ENV['SECRET'])
    todo = Todo.new(user_id: confirm[:ok][:id], text: params[:text])
    todo.completed = false
    todo.save!
    render json: todo
  rescue
    render json: {'error': 'invalid JWT'}
  end

end
