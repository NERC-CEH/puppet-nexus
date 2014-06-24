require 'net/http'
require 'rexml/document'

module Puppet::Parser::Functions
  # Resolves the given gav + ext + repo parameters with a given nexus
  # instance. Returns the location of the artifact and its sha1 value
  newfunction(:resolve, :type => :rvalue) do |args|
    #Read in the arguments list
    nexus,repo,group,artifact,version,extension,classifier = args

    resolved = "#{nexus}/artifact/maven/resolve?r=#{repo}&v=#{version}&g=#{group}&a=#{artifact}&e=#{extension}&c=#{classifier}"
    xml_data = Net::HTTP.get(URI.parse(resolved))
    doc = REXML::Document.new(xml_data) #Parse the xml for the resolved artifact
    version = REXML::XPath.first(doc, "/artifact-resolution/data/version").text
    sha1 = REXML::XPath.first(doc, "/artifact-resolution/data/sha1").text
    redirect = "#{nexus}/artifact/maven/redirect?r=#{repo}&v=#{version}&g=#{group}&a=#{artifact}&e=#{extension}&c=#{classifier}"
    redirectRes = Net::HTTP.get_response(URI.parse(redirect)) #get the real location of the artifact

    return {
      'location' => URI.parse(redirectRes['location']),
      'sha1'     => sha1
    }
  end
end