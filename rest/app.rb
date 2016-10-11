require 'sinatra'
require 'docker'
set :bind, '0.0.0.0'
get '/version' do
  Docker.version.to_json
end

post '/echo' do
  request.body.rewind
  container = Docker::Container.create('Image' => 'echo', Cmd: [request.body.read])
  resp, error_messages = container.tap(&:start).attach(logs: true)
  $stderr.puts "GOT ERRORS #{error_messages.join("\n")}"
  container.remove
  resp.join('')
end

post '/cat' do
  request.body.rewind
  container = Docker::Container.create('Image' => 'cat', 'OpenStdin' => true, 'StdinOnce' => true)
  resp, error_messages = container.tap(&:start).attach(stdin: StringIO.new("#{request.body.read}\n"))
  $stderr.puts "GOT ERRORS #{error_messages.join("\n")}"
  container.remove
  resp.join('')
end
