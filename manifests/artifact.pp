# == Define: nexus::artifact
#
# Use this resource to obtain an artifact from a nexus repository. You can 
# use nexus version tags such as 'LATEST', to ensure that you get the latest
# release of an artifact
#
# === Parameters
#
# [*nexus*] The $nexus instance to obtain the artifact from
# [*group*] The $group parameter of the artifact
# [*artifact*] The $artifact to obtain
# [*location*] The $location to load the artifact to
# [*version*] The $version of the artifact to obtain, defaults to LATEST
# [*extension*] The $extension of the artifact to get
# [*classifier*] The $classifier of the artifact to get
# [*repo*] The $repo on the nexus instance to obtain the artifact from
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
#
define nexus::artifact(
  $nexus,
  $group,
  $artifact,
  $location   = $title,
  $version    = 'LATEST',
  $extension  = 'war',
  $classifier = '',
  $repo       = 'public'
) {
  $webArtifact = resolve($nexus, $repo, $group, $artifact, $version, $extension, $classifier)
  $temp = "/tmp/${webArtifact['sha1']}"

  exec { "obtain_artifact $location":
    command   => "wget '${webArtifact['location']}' -O ${temp}",
    creates   => $temp,
    path      => ['/usr/bin'],
  }

  file { $location :
    source  => $temp,
    require => Exec["obtain_artifact $location"],
  }
}
