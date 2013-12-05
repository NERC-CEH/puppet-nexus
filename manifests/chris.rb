require 'net/http'
require 'rexml/document'

def wget(uri, output)
  Net::HTTP.start(uri.host, uri.port) do |http|
    request = Net::HTTP::Get.new uri

    http.request request do |response|
      open output, 'wb' do |io|
        response.read_body do |chunk|
          io.write chunk
        end
      end
    end
  end
end



nexus = 'http://mavenrepo.nerc-lancaster.ac.uk/nexus/service/local'
repo = 'releases'
a = 'ukeof-web'
g = 'uk.org.ukeof'
e = 'war'
v = '0.7'

resolved = "#{nexus}/artifact/maven/resolve?r=#{repo}&v=#{v}&g=#{g}&a=#{a}&e=#{e}"

xml_data = Net::HTTP.get(URI.parse(resolved))

doc = REXML::Document.new(xml_data)

version = REXML::XPath.first(doc, "/artifact-resolution/data/version").text

redirect = "#{nexus}/artifact/maven/redirect?r=#{repo}&v=#{version}&g=#{g}&a=#{a}&e=#{e}"

redirectRes = Net::HTTP.get_response(URI.parse(redirect))


uri = URI.parse(redirectRes['location'])


