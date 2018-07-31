require 'spec_helper'

# Since I'm testing on my mac, I have to set a fact for root_home
test_facts = { :root_home => '/root' }

describe 'roles::db::test' do
  on_supported_os.each do |os,facts|
    context "with OS #{os}" do
     let(:facts) do
        facts.merge(test_facts)
      end
     it { is_expected.to compile.with_all_deps }
     it { is_expected.to contain_class('profiles::base') }
     it { is_expected.to contain_class('profiles::mysql::test_db') }
    end
  end
end
