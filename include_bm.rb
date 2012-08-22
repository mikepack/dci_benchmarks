require 'benchmark'
require './runner'

class IncludeUser
  include Runner
end

class Context
  def self.call
    user = IncludeUser.new
    user.run
  end
end

Benchmark.bm do |bench|
  3.times do
    bench.report('include') do
      1000000.times do
        Context.call
      end
    end
  end
end