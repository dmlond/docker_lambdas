Gem::Specification.new do |spec|
  spec.name          = "lita-lambda"
  spec.version       = "0.1.0"
  spec.authors       = ["Darin London"]
  spec.email         = ["Lita Plugin for the Docker Lambdas"]
  spec.description   = "Lita Plugin for the Docker Lambdas"
  spec.summary       = "TODO: Add a summary"
  spec.homepage      = "TODO: Add a homepage"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.7"
  spec.add_dependency "docker-api"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
