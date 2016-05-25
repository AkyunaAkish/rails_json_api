require 'rails_helper'

describe "User" do
  it "can sign up" do
    name = "Elowyn"
    password = "iLuvS0up"
    post '/signup', params = {name: name, password: password}
    expect(JSON.parse(last_response.body)['name']).to eq(name)
    expect(User.last.name).to eq(name)
  end
end
