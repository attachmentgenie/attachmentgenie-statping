require 'spec_helper'
describe 'statping' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('statping') }
        it { is_expected.to contain_anchor('statping::begin').that_comes_before('Class[statping::Install]') }
        it { is_expected.to contain_class('statping::install').that_comes_before('Class[statping::Config]') }
        it { is_expected.to contain_class('statping::config').that_notifies('Class[statping::Service]') }
        it { is_expected.to contain_class('statping::service').that_comes_before('Anchor[statping::end]') }
        it { is_expected.to contain_anchor('statping::end') }
        it { is_expected.to contain_group('statping') }
        it { is_expected.to contain_package('statping') }
        it { is_expected.to contain_service('statping') }
        it { is_expected.to contain_user('statping') }
      end
    end
  end
end
