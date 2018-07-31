require 'spec_helper'

# Since I'm testing on my mac, I have to set a fact for root_home
test_facts = { :root_home => '/root' }

describe 'profiles::mysql::test_db' do
  on_supported_os.each do |os,facts|
    context "with OS #{os}" do
      let(:facts) do
        facts.merge(test_facts)
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to include_class('profiles::mysql') }
      it do
        is_expected.to contain_mysql__db('test_db').with(
          user: 'test_user',
          password: 'test_password',
          host: 'localhost',
          grant: ['SELECT','UPDATE'],
        )
      end
    end
  end
end
