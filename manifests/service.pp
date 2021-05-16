# Class to manage the statping service.
#
# @api private
class statping::service {
  if $::statping::manage_service {
    case $::statping::service_provider {
      'systemd': {
        ::systemd::unit_file { "${::statping::service_name}.service":
          content => template('statping/statping.service.erb'),
          notify  => Service['statping'],
        }
      }
      default: {
        fail("Service provider ${::statping::service_provider} not supported")
      }
    }

    case $::statping::install_method {
      'archive': {
        Service['statping'] {
          subscribe => File['config.yml'],
        }
      }
      'package': {
        Service['statping'] {
          subscribe => [File['config.yml'], Package['statping']],
        }
      }
      default: {
        fail("Installation method ${::statping::install_method} not supported")
      }
    }

    service { 'statping':
      ensure   => $::statping::service_ensure,
      enable   => true,
      name     => $::statping::service_name,
      provider => $::statping::service_provider,
    }
  }
}
