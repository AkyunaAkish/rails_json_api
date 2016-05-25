class AuthController < ApplicationController

  def signup
    user = User.new(name: params[:name])
    user.password = params[:password]
    if user.save
      render :json => {id: user.id, name: user.name}
    else
      render status: 400, :json => {error: "Name already exists in the database"}
    end
  end

  def login
    user = User.find_by(name: params[:name])
    if user.password == params[:password]
      render :json => {id: user.id, name: user.name}
    else
      render status: 400, :json => {error: "Name or password is incorrect"}
    end
  end

end
