#
# Definition: nexus::params
#
# This class manages the nexus parameters
#
# Authors:
#   Christopher Johnson - cjohn@ceh.ac.uk
#
# Parameters:
# - The default $nexus instance to obtain artifacts from
# - The default $repo in the $nexus instance to obtain artifacts from
# - The default $version of artifacts to obtain 
#
class nexus::params {
  $nexus = 'http://mavenrepo.nerc-lancaster.ac.uk/nexus/service/local',
  $repo = 'public',
  $version = 'LATEST',
}