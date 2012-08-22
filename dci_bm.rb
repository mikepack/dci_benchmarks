require 'benchmark'
require './runner'

class DCIUser; end

class Context
  def self.call
    user = DCIUser.new
    user.extend Runner
    user.run
  end
end

Benchmark.bm do |bench|
  3.times do
    bench.report('DCI') do
      1000000.times do
        Context.call
      end
    end
  end
end