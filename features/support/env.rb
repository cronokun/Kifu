$: << File.join(File.dirname(__FILE__), '/../../lib' )

require 'aruba/cucumber'
require 'kifu'

Before do
  @dirs = ['.']
end
