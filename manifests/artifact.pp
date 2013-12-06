define nexus::artifact(
  $location = $title,
  $nexus = 'http://mavenrepo.nerc-lancaster.ac.uk/nexus/service/local',
  $repo = 'releases',
  $group,
  $artifact,
  $version,
  $extension = 'war'
) {
  $webArtifact = resolve($nexus, $repo, $group, $artifact, $version, $extension)
  $temp = "/tmp/${webArtifact['sha1']}"

  exec { 'obtain_artifact':
    command   => "wget ${webArtifact['location']} -O ${temp}",
    creates   => $temp,
    path      => ['/usr/bin'],
    logoutput => true,
  }

  file { $location :
    source  => $temp,
    require => Exec['obtain_artifact'],
  }
}