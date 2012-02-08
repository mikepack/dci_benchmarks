require 'perftools'
require 'mixology'
require './runner'

class DCIUser; end

PerfTools::CpuProfiler.start('/tmp/mixology_profile') do
  1000000.times do
    user = DCIUser.new
    user.mixin Runner
    user.run
    user.unmix Runner
  end
end