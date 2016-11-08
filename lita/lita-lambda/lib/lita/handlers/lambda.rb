require 'docker'
module Lita
  module Handlers
    class Lambda < Handler
      #helper methods

      # insert handler code here
      route(/^(.+)/,
        :run_lambda,
        command: true,
        help: { "COMMAND [args]" =>
          "Passes all args as the arguments to COMMAND. COMMAND must be registered in the system."
      })

      def run_lambda(response)
        # response.reply "RECIEVED #{response.message.body} from #{response.message.source.room_object.inspect}"
        command_args = response.message.body.split(' ')
        command = command_args.shift
        begin
          # command_image = Docker::Image.get(command)
          container = Docker::Container.create('Image' => command, 'OpenStdin' => true, 'StdinOnce' => true)
          resp, error_messages = container.tap(&:start).attach(stdin: StringIO.new("#{command_args.join(' ')}\n"))
          log.warn "GOT ERRORS #{error_messages.join("\n")}"
          container.remove
          message = resp.join('')
          response.reply("#{message}")
        rescue Docker::Error::NotFoundError
          response.reply("#{command} not found")
        end
      end

      Lita.register_handler(self)
    end
  end
end
