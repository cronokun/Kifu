require 'lib/kifu/version'

$gemspec = Gem::Specification.new do |g|
  g.name = 'kifu'
  g.version = Kifu::VERSION::STRING
  g.author = 'Sergey Kviatkovsky'
  g.email = 'cronokun@me.com'
  g.homepage = 'http://github.com/cronokun/kifu'
  g.platform = Gem::Platform::RUBY
  g.summary = 'Print go game kifus from SGF files as ASCII, HTML or PDF.'
end
