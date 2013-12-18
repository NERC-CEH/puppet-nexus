#
# Definition: nexus
#
# This is the nexus class, will create instances of nexus powered by tomcat
#
# Authors:
#   Christopher Johnson - cjohn@ceh.ac.uk
#
# Parameters:
# - The $port to host nexus on
# - The $nexus repository to obtain the nexus artifact from
# - The $version of nexus to deploy
# - The $repo to obtain the nexus artifact from
#
class nexus (
  $port = 80,
  $nexus = $nexus::params::nexus,
  $version = $nexus::params::version,
  $repo = $nexus::params::repo
) inherits nexus::params {

  tomcat::instance { 'nexus' :
    http_port => $port
  }

  tomcat::deployment { 'Deploy the nexus app':
    application => 'ROOT',
    tomcat      => 'nexus',
    nexus       => $nexus,
    repo        => $repo,
    group       => 'org.sonatype.nexus',
    artifact    => 'nexus-webapp',
    version     => $version,
  }
}