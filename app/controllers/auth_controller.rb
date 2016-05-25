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

end
