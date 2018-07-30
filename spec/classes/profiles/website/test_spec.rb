require 'spec_helper'

describe 'profiles::website::test' do
  on_supported_os.each do |os, facts|
    context "with OS #{os}" do
      let(:facts) do
        facts
      end
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_file('/var/www/html/index.php').with(
          ensure: 'file',
          owner: 'root',
          group: 'apache',
          mode: '0640',
          source: 'puppet:///modules/profiles/php/index.php'
        )
      end
    end
  end
end
