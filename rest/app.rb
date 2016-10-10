require 'sinatra'
require 'docker'
set :bind, '0.0.0.0'
get '/version' do
  Docker.version.to_json
end

post '/echo' do
  request.body.rewind
  container = Docker::Container.create('Image' => 'echo', Cmd: [request.body.read])
  resp = container.tap(&:start).attach(logs: true)[0][0]
  container.remove
  resp
end
