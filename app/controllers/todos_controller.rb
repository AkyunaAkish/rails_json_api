class TodosController < ApplicationController

  def index
    confirm = JsonWebToken.verify(params[:jwt], key: ENV['SECRET'])
    render json: Todo.where(user_id: confirm[:ok][:id])
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
