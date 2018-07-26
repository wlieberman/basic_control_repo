require 'spec_helper'

describe 'profiles::website::test' do
  on_supported_os.each do |os, facts|
    context "with OS #{os}" do
      let(:facts) do
        facts
      end
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_file.with(
          ensure: 'file',
          owner: 'root',
          group: 'root',
          mode: '0640',
          source: 'puppet:///modules/${module_name}/php/index.php'
        )
      end
    end
  end
end
