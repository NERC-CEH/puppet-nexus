# == Define: nexus::artifact
#
# Use this resource to obtain an artifact from a nexus repository. You can 
# use nexus version tags such as 'LATEST', to ensure that you get the latest
# release of an artifact
#
# === Parameters
#
# [*group*] The $group parameter of the artifact
# [*artifact*] The $artifact to obtain
# [*location*] The $location to load the artifact to
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
define nexus::artifact(
  $group,
  $artifact,
  $location   = $title,
  $version    = $nexus::version,
  $extension  = $nexus::extension,
  $classifier = $nexus::classifier,
  $nexus      = $nexus::nexus,
  $repo       = $nexus::repo
) {
  if ! defined(Class['nexus']) {
    fail('You must include the nexus base class before declaring any nexus artifacts resources')
  }

  $sha1 = resolve_sha1($nexus, $repo, $group, $artifact, $version, $extension, $classifier)
  $webArtifact = "${nexus}/artifact/maven/redirect?r=${repo}&v=${version}&g=${group}&a=${artifact}&e=${extension}&c=${classifier}"
  $temp = "/tmp/${sha1}"

  exec { "obtain_artifact $location":
    command   => "wget '${webArtifact}' -O ${temp}",
    creates   => $temp,
    path      => ['/usr/bin'],
  }

  file { $location :
    source  => $temp,
    require => Exec["obtain_artifact $location"],
  }
}
