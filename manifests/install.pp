# Class to install statping.
#
# @api private
class statping::install {
  if $::statping::manage_user {
    user { 'statping':
      ensure => present,
      home   => $::statping::install_dir,
      name   => $::statping::user,
    }
    group { 'statping':
      ensure => present,
      name   => $::statping::group
    }
  }
  case $::statping::install_method {
    'package': {
      package { 'statping':
        ensure => $::statping::package_version,
        name   => $::statping::package_name,
      }
    }
    'archive': {
      file { 'statping install dir':
        ensure => directory,
        group  => $::statping::group,
        owner  => $::statping::user,
        path   => $::statping::install_dir,
      }
      if $::statping::manage_user {
        File[$::statping::install_dir] {
          require => [Group['statping'],User['statping']],
        }
      }

      archive { 'statping archive':
        cleanup      => true,
        creates      => "${::statping::install_dir}/statping",
        extract      => true,
        extract_path => $::statping::install_dir,
        group        => $::statping::group,
        path         => '/tmp/statping.tar.gz',
        source       => $::statping::archive_source,
        user         => $::statping::user,
        require      => File['statping install dir']
      }

    }
    default: {
      fail("Installation method ${::statping::install_method} not supported")
    }
  }
}
