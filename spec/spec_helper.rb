require 'puppetlabs_spec_helper/module_spec_helper'
require File.dirname(__FILE__) + '/lib/puppet/type/file_line.rb'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
  # c.after(:suite) do
  #   RSpec::Puppet::Coverage.report!
  # end

  c.before :each do
    # Work even if you don't specify facts
    f = self.respond_to?(:facts) ? facts : {}

    # Automatically detect whether we're pretending to run on Windows
    Thread.current[:windows?] = true if f[:kernel] == 'windows'
  end

  c.after :each do
    Thread.current[:windows?] = nil
    Facter.clear
  end

end

module Puppet
  module Util
    class << Platform
      alias_method :orig_windows?, :windows?

      def windows_override?
        Thread.current[:windows?]
      end

      # we need to be selective here
      # there are things like the puppet auto loader that
      # fail if we pretend to be on windows.
      # TODO consider directly monkey patching puppet file type.

      def matching_callers
        caller.select do |line|
          case line
            when %r{puppet/provider/exec.*validatecmd}    then true
            when %r{puppet/type/file}                     then true
            when %r{puppet/parameter/path.*validate_path} then true
            else false
          end
        end
      end

      def caller_needs_override?
        !matching_callers.empty?
      end

      def windows?
        # This is where Puppet normally looks for the target OS.
        # It normally returns the *current* OS (i.e., not Windows,
        # if you're not running the specs on Windows)

        if windows_override? && caller_needs_override?
          true
        else
          orig_windows?
        end
      end
    end
  end
end
