require 'net/http'
require 'rexml/document'


module Puppet::Parser::Functions
  newfunction(:resolve, :type => :rvalue) do |args|
    #Read in the arguments list
    nexus,repo,group,artifact,version,extension = args

    resolved = "#{nexus}/artifact/maven/resolve?r=#{repo}&v=#{version}&g=#{group}&a=#{artifact}&e=#{extension}"
    xml_data = Net::HTTP.get(URI.parse(resolved))
    doc = REXML::Document.new(xml_data)
    version = REXML::XPath.first(doc, "/artifact-resolution/data/version").text
    sha1 = REXML::XPath.first(doc, "/artifact-resolution/data/sha1").text
    redirect = "#{nexus}/artifact/maven/redirect?r=#{repo}&v=#{version}&g=#{group}&a=#{artifact}&e=#{extension}"
    redirectRes = Net::HTTP.get_response(URI.parse(redirect))

    return {
      'location' => URI.parse(redirectRes['location']),
      'sha1'     => sha1
    }
  end
end