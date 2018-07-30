require 'spec_helper'

describe 'profiles::apache' do
  on_supported_os.each do |os, facts|
    context "with OS #{os}" do
      let(:facts) do
        facts
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('apache') }
      it { is_expected.to contain_class('apache::mod::php') }
      it do
        is_expected.to contain_firewall('100 allow http and https access').with(
          port: [80, 443],
          proto: 'tcp',
          action: 'accept'
        )
      end
    end
  end
end