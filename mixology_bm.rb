require 'benchmark'
require 'mixology'
require './runner'

class DCIUser; end

Benchmark.bm do |bench|
  bench.report('#extend') do
    1000000.times do
      user = DCIUser.new
      user.extend Runner
      user.run
    end
  end
  bench.report('mixology w/o #unmix') do
    1000000.times do
      user = DCIUser.new
      user.mixin Runner
      user.run
    end
  end
  bench.report('mixology w/ #unmix') do
    1000000.times do
      user = DCIUser.new
      user.mixin Runner
      user.run
      user.unmix Runner
    end
  end
end