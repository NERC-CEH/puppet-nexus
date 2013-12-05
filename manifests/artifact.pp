define nexus::artifact(
  $location = $title,
  $nexus = 'http://mavenrepo.nerc-lancaster.ac.uk/nexus/service/local',
  $repo = 'releases',
  $group,
  $artifact,
  $version,
  $extension = 'war'
) {
  $temp     = "/tmp/nexus"
  $webArtifact = template('nexus/location.erb')

  exec { 'obtain_artifact':
    command => "wget ${webArtifact} -O ${temp}",
    path => ['/usr/bin'],
  }

  file { $location :
    source  => $temp,
    require => Exec['obtain_artifact'],
  }
}