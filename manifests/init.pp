# == Class: nexus
#
# Empty class to define the nexus namespace and default parameters
#
# === Parameters
#
# [*version*] The $version of the artifact to obtain, defaults to LATEST
# [*extension*] The $extension of the artifact to get
# [*classifier*] The $classifier of the artifact to get
# [*nexus*] The $nexus instance to obtain the artifact from
# [*repo*] The $repo on the nexus instance to obtain the artifact from
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
#
class nexus (
  $version    = 'LATEST',
  $extension  = 'war',
  $classifier = '',
  $nexus      = 'https://oss.sonatype.org/service/local',
  $repo       = 'public'
) {}
