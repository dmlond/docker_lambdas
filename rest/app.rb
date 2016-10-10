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

post '/cat' do
  request.body.rewind
  container = Docker::Container.create('Image' => 'cat', 'OpenStdin' => true, 'StdinOnce' => true)
  resp = container.tap(&:start).attach(stdin: StringIO.new("#{request.body.read}\n"))[0][0]
  container.remove
  resp
end
