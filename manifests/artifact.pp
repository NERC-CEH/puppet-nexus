define nexus::artifact(
  $location = $title,
  $nexus = 'http://mavenrepo.nerc-lancaster.ac.uk/nexus/service/local'
  $repo = 'releases',
  $group,
  $artifact,
  $version,
  $extension = 'war'
) {
  $temp     = "/tmp/nexus"
  $location = template('nexus/location.erb')

  exec { 'obtain_artifact':
    command => "wget ${location} -O ${temp}",
    require => Package['wget'],
  }

  file { $location :
    source  => $temp
    require => Exec['obtain_artifact']
  }
}