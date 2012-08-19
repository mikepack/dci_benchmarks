require 'benchmark'

class User; end

module Runner
  refine User do
    def run
      Math.tan(Math::PI / 4)
    end
  end
end

class Context
  using Runner

  def self.run
    user = User.new
    user.run
  end
end

Benchmark.bm do |bench|
  3.times do
    bench.report('refine') do
      1000000.times do
        Context.run
      end
    end
  end
end