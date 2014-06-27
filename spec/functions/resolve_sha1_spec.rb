require 'spec_helper'

describe "resolve_sha1" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("resolve_sha1")).to eq("function_resolve_sha1")
  end

  it "should return sha1 for valid parameters" do
    result = scope.function_resolve_sha1(['https://oss.sonatype.org/service/local',
                                          'public',
                                          'uk.ac.ceh',
                                          'dynamo-mapping',
                                          '0.1',
                                          'jar'])
    expect(result).to(eq('f645a04f5354ff2251fc9f5a7de86a510d7faf1c'))
  end

  it "should fail if the artifact cant be located" do
    expect {scope.function_resolve_sha1('https://oss.sonatype.org/service/local',
                                        'public',
                                        'some.nonsense',
                                        'invalid',
                                        '0.1',
                                        'jar') }
    .to( raise_error(ArgumentError) )
  end

  it "should fail if the nexus server does not exist" do
    expect {scope.function_resolve_sha1('some/random/nexus/server',
                                        'public',
                                        'some.nonsense',
                                        'invalid',
                                        '0.1',
                                        'jar') }
    .to( raise_error(ArgumentError) )
  end    
end
