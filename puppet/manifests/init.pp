# == Class: puppet
#
# Full description of class puppet here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'puppet':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class puppet {
  # Make sure 'puppet' is installed
  package { 'puppet-agent':
    ensure	=> installed,
  }

  # Make sure 'puppet' has the correct configuration
  file { '/etc/puppetlabs/puppet/puppet.conf':
    content 	=> template("${module_name}/puppet_conf.erb"),
    owner	=> root,
    group	=> root,
    mode	=> '644',
    #notify	=> Service['puppet'], # puppet will restart whenever this file change
    require 	=> Package['puppet-agent'],
   }

  # Make sure 'puppet' is always running
  service { 'puppet':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
  }
}

