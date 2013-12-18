# == Define: nexus::artifact
#
# Use this resource to obtain an artifact from a nexus repository. You can 
# use nexus version tags such as 'LATEST', to ensure that you get the latest
# release of an artifact
#
# === Parameters
# [*group*]
#   The $group parameter of the artifact
# [*artifact*]
#   The $artifact to obtain
# [*location*]
#   The $location to load the artifact to
# [*version*]
#   The $version of the artifact to obtain, defaults to LATEST
# [*extension*]
#   The $extension of the artifact to get
# [*nexus*]
#   The $nexus instance to obtain the artifact from
# [*repo*]
#   The $repo on the nexus instance to obtain the artifact from
#
# === Authors
#
#   Christopher Johnson - cjohn@ceh.ac.uk
#
define nexus::artifact(
  $group,
  $artifact,
  $location   = $title,
  $version    = 'LATEST',
  $extension  = 'war',
  $nexus      = 'http://mavenrepo.nerc-lancaster.ac.uk/nexus/service/local',
  $repo       = 'public'
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
