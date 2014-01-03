Gem::Specification.new do |gem|
  gem.name    = 'usbank'
  gem.version = '0.0.0'
  gem.date    = Date.today.to_s

  gem.summary = "a gem to fetch transaction data from usbank"
  gem.description = "a gem to fetch transaction data from usbank"

  gem.authors  = ['Ed Lebert']
  gem.email    = 'edlebert@gmail.com'
  gem.homepage = 'http://github.com/edlebert/usbank'

  gem.add_dependency('mechanize', '~> 2.0')

  # ensure the gem is built out of versioned files
  gem.files = Dir['lib/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  gem.require_paths = ['lib']
end