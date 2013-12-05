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

  Exec {
    path => ['/usr/bin'],
  }

  exec { 'obtain_artifact':
    command => "wget ${webArtifact} -O ${temp}",
    require => Package['wget'],
  }

  file { $location :
    source  => $temp,
    require => Exec['obtain_artifact'],
  }
}