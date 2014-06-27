require 'open-uri'
require 'rexml/document'

module Puppet::Parser::Functions
  # Resolves the given gav + ext + repo parameters with a given nexus
  # instance. Returns the given maven artifacts sha1 value
  newfunction(:resolve_sha1, :type => :rvalue) do |args|
    #Read in the arguments list
    nexus,repo,group,artifact,version,extension,classifier = args

    resolved = "#{nexus}/artifact/maven/resolve?r=#{repo}&v=#{version}&g=#{group}&a=#{artifact}&e=#{extension}&c=#{classifier}"
    xml_data = open(resolved).read
    doc = REXML::Document.new(xml_data) #Parse the xml for the resolved artifact
    version = REXML::XPath.first(doc, "/artifact-resolution/data/version").text
    return REXML::XPath.first(doc, "/artifact-resolution/data/sha1").text    
  end
end
