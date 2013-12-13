################################################################################
# Definition: nexus::artifact
#
# Use this resource to obtain an artifact from a nexus repository. You can 
# use nexus version tags such as 'LATEST', to ensure that you get the latest
# release of an artifact
#
################################################################################
define nexus::artifact(
  $location = $title,
  $nexus = 'http://mavenrepo.nerc-lancaster.ac.uk/nexus/service/local',
  $repo = 'public',
  $group,
  $artifact,
  $version = 'LATEST',
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
