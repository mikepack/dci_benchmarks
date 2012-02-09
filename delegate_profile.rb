require 'perftools'
require 'delegate'
require './runner'

class DCIUser; end

class RunnerDelegator < SimpleDelegator
  include Runner
end

PerfTools::CpuProfiler.start('/tmp/delegate_profile') do
  1000000.times do
    user = DCIUser.new
    user = RunnerDelegator.new(user)
    user.run
  end
end