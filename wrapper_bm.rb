require 'benchmark'
require 'schizo'
require 'delegate'
require 'forwardable'
require './runner'

class DCIUser; end

class SchizoUser
  include Schizo::Data
end

module SchizoRunner
  extend Schizo::Role
  include Runner
end

class RunnerDelegator < SimpleDelegator
  def initialize(user)
    @user = user.dup.extend Runner
    super(@user)
  end
end

class RunnerForwarder
  extend Forwardable
  def_delegator :@user, :run

  def initialize(user)
    @user = user.dup.extend Runner
  end
end

Benchmark.bm do |bench|
  bench.report('Delegation') do
    1000000.times do
      user = DCIUser.new
      user = RunnerDelegator.new(user)
      user.run
    end
  end

  bench.report('Forwardable') do
    1000000.times do
      user = DCIUser.new
      user = RunnerForwarder.new(user)
      user.run
    end
  end
  
  bench.report('Schizo') do
    1000000.times do
      user = SchizoUser.new
      user.as(SchizoRunner) do |runner|
        runner.run
      end
    end
  end
end