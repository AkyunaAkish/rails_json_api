class AuthController < ApplicationController
  require 'json_web_token'

  def signup
    user = User.new(name: params[:name])
    user.password = params[:password]
    if user.save
      jwt = JsonWebToken.sign({id: user.id}, key: ENV['SECRET'])
      render :json => {id: user.id, name: user.name, jwt: jwt}
    else
      render status: 400, :json => {error: "Name already exists in the database"}
    end
  end

  def signin
    user = User.find_by(name: params[:name])
    if user.password == params[:password]
      jwt = JsonWebToken.sign({id: user.id}, key: ENV['SECRET'])
      render :json => {id: user.id, name: user.name, jwt: jwt}
    else
      render status: 400, :json => {error: "Name or password is incorrect"}
    end
  end

end
