class TodosController < ApplicationController

  def index
    render json: Todo.all
  end

  def create
    if params[:user_id] && params[:jwt] && params[:text] # check token!!!! PLEASE
      todo = Todo.new(user_id: params[:user_id], text: params[:text])
      todo.completed = false
      todo.save!
      render json: todo
    else
      render status: 400, json: {error: "Todo could not be created"}
    end
  end

end
