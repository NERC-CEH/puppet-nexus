source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'rake', '10.3.2',          :require => false
  gem 'rspec-puppet', '>=1.0.0', :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'serverspec',              :require => false
  gem 'puppet-lint',             :require => false
  gem 'beaker',                  :require => false
  gem 'beaker-rspec',            :require => false
  gem 'rspec', '~> 3.0.0',       :require => false
end  

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end