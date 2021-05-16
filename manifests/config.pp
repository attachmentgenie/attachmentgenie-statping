# Class to configure statping.
#
# @api private
class statping::config {
  file { $statping::config_dir:
    ensure => directory,
    owner  => $::statping::user,
    group  => $::statping::group,
  }
  -> file { 'config.yml':
    ensure  => 'file',
    path    => "${statping::install_dir}/config.yml",
    owner   => $::statping::user,
    group   => $::statping::group,
    content => $statping::config.to_yaml,
  }
}