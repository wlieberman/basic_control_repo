require 'spec_helper'

describe 'roles::webserver' do
  on_supported_os.each do |os, facts|
    context "with OS #{os}" do
      let(:facts) do
        facts
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('profiles::base') }
      it { is_expected.to contain_class('profiles::apache') }
      it { is_expected.to contain_class('profiles::website::test').that_requires('Class[profiles::apache]') }
    end
  end
end
