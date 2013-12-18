#
# Definition: nexus::artifact
#
# Use this resource to obtain an artifact from a nexus repository. You can 
# use nexus version tags such as 'LATEST', to ensure that you get the latest
# release of an artifact
#
# Authors:
#   Christopher Johnson - cjohn@ceh.ac.uk
#
# Parameters:
# - The $location to load the artifact to
# - The $nexus instance to obtain the artifact from
# - The $repo on the nexus instance to obtain the artifact from
# - The $group parameter of the artifact
# - The $artifact to obtain
# - The $version of the artifact to obtain, defaults to LATEST
# - The $extension of the artifact to get
#
define nexus::artifact(
  $location = $title,
  $nexus = $nexus::params::nexus,
  $repo = $nexus::params::repo,
  $group,
  $artifact,
  $version = $nexus::params::version,
  $extension = 'war'
) {

  $webArtifact = resolve($nexus, $repo, $group, $artifact, $version, $extension)
  $temp = "/tmp/${webArtifact['sha1']}"

  exec { "obtain_artifact $location":
    command   => "wget ${webArtifact['location']} -O ${temp}",
    creates   => $temp,
    path      => ['/usr/bin'],
  }

  file { $location :
    source  => $temp,
    require => Exec["obtain_artifact $location"],
  }
}
