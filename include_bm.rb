require 'benchmark'
require './runner'

class IncludeUser
  include Runner
end

class Context
  def self.run
    user = IncludeUser.new
    user.run
  end
end

Benchmark.bm do |bench|
  3.times do
    bench.report('include') do
      1000000.times do
        Context.run
      end
    end
  end
end