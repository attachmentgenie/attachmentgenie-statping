# Class to install and configure statping.
#
# Use this module to install and configure statping.
#
# @statping Declaring the class
#   include ::statping
#
# @param archive_source Location of statping binary release.
# @param group Group that owns statping files.
# @param install_dir Location of statping binary release.
# @param install_method How to install statping.
# @param manage_service Manage the statping service.
# @param manage_user Manage statping user and group.
# @param package_name Name of package to install.
# @param package_version Version of statping to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param user User that owns statping files.
class statping (
  Hash $config,
  Stdlib::Absolutepath $config_dir,
  String[1] $group,
  String $http_addr,
  Stdlib::Port $http_port,
  Stdlib::Absolutepath $install_dir,
  Enum['archive','package'] $install_method ,
  Boolean $manage_service,
  Boolean $manage_user,
  String[1] $package_name,
  String[1] $package_version,
  String[1] $service_name,
  String[1] $service_provider,
  Enum['running','stopped'] $service_ensure,
  String[1] $user,
  Optional[Stdlib::HTTPUrl] $archive_source = undef,
) {
  anchor { 'statping::begin': }
  -> class{ '::statping::install': }
  -> class{ '::statping::config': }
  ~> class{ '::statping::service': }
  -> anchor { 'statping::end': }
}
