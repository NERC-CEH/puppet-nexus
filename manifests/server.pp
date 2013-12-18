# == Class: nexus::server
#
# This is the nexus class, will create instances of nexus powered by tomcat
#
# === Parameters
#
# [*port*]
#   The $port to host nexus on
# [*nexus*]
#   The $nexus repository to obtain the nexus artifact from
# [*version*]
#   The $version of nexus to deploy
# [*repo*]
#   The $repo to obtain the nexus artifact from
#
# === Authors
#
#   Christopher Johnson - cjohn@ceh.ac.uk
#
class nexus::server (
  $port     = 80,
  $nexus    = undef,
  $version  = undef,
  $repo     = undef
) {

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