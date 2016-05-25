class AuthController < ApplicationController

  def signup
    user = User.new(name: params[:name])
    user.password = params[:password]
    user.save!
    render :json => {id: user.id, name: user.name}
  end

end
