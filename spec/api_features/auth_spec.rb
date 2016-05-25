require 'rails_helper'

describe "User" do
  it "can sign up" do
    name = "Elowyn"
    password = "iLuvS0up"
    post '/signup', params = {name: name, password: password}
    expect(JSON.parse(last_response.body)['name']).to eq(name)
    expect(User.last.name).to eq(name)
  end

  it "cannot sign up with duplicate name" do
    user = User.new(name: "Elowyn")
    user.password = "iLuvS0up"
    user.save!

    duplicate_user = {name: "Elowyn", password: 'password'}
    post '/signup', params = duplicate_user
    expect(last_response.status).to_not eq(200)
    expect(JSON.parse(last_response.body)).to eq("error"=>"Name already exists in the database")
    expect(User.all.length).to be(1)
  end

  it "can be authenticated" do
    name = "Elowyn"
    password = "iLuvS0up"
    user = User.new(name: name)
    user.password = password
    user.save!

    post '/login', params = {name: name, password: password}
    expect(JSON.parse(last_response.body)['id']).to eq(User.last.id)
    expect(JSON.parse(last_response.body)['name']).to eq(name)
  end

end
