require 'spec_helper'

describe 'nexus::artifact', :type => :define do 
  nexusServer = 'https://oss.sonatype.org/service/local/artifact'

  let :pre_condition do
    'include "nexus"'
  end

  describe 'obtaining the dynamo mapping library' do
    expectedPath = '/tmp/2df28413d30c98814b9497e344cb72d04122454a'

    let(:title) { 'dynamo-maps' }
    let(:params) {{
      :group     => 'uk.ac.ceh',
      :artifact  => 'dynamo-mapping',
      :version   => '1.0',
      :extension => 'jar',
      :location  => '/some/path.jar'
    }}
    it { should contain_exec('obtain_artifact /some/path.jar').with(
      :command => "wget '#{nexusServer}/maven/redirect?r=public&v=1.0&g=uk.ac.ceh&a=dynamo-mapping&e=jar&c=' -O #{expectedPath}",
      :creates => expectedPath,
      :path    => '/usr/bin'
    ) }
    it { should contain_file('/some/path.jar').with( :source => expectedPath )
                                              .that_requires( 'Exec[obtain_artifact /some/path.jar]' ) }
  end
end
