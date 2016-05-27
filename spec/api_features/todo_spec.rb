require 'rails_helper'

describe 'Todos' do
  it 'can be created and listed, only see own todos' do
    emily = User.create!(
      name: "Emily",
      password: "iLuvElowyn",
    )
    Todo.create!(
      text: "Drive a car",
      user_id: emily.id,
      completed: false,
    )

    name = "Elowyn"
    password = "iLuvS0up"
    post '/signup', params = {name: name, password: password}
    jwt = JSON.parse(last_response.body)['jwt']
    get '/todos', params = {user_id: User.last.id, jwt: jwt}
    expect(JSON.parse(last_response.body)).to eq([])

    post '/todos', params = {text: "Drink some milk", user_id: User.last.id, jwt: jwt}

    actual = JSON.parse(last_response.body)
    expect(actual["text"]).to eq("Drink some milk")
    expect(actual["user_id"]).to eq(User.last.id)
    expect(actual["completed"]).to be(false)

    get '/todos', params = {user_id: User.last.id, jwt: jwt}
    expect(JSON.parse(last_response.body).length).to eq(1)
  end
end
