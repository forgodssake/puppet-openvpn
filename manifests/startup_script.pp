# Class: openvpn::startup_script
#
# Example Usage:
#  $tapdev = 'tap1'
#  $tapbridge = 'br1'
#  class { 'openvpn::startup_script':
#      content => template('openvpn/openvpn-startup.erb'),
#  }
#
class openvpn::startup_script (
  $dir = '/etc/openvpn',
  $source  = undef,
  $content = undef
) {

  include '::openvpn::params'
  # Multi-service is tricky, many service names...
  if ! $::openvpn::params::multiservice {
    File["${dir}/openvpn-startup"] ~> Service['openvpn']
  }

  file { "${dir}/openvpn-startup":
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    source  => $source,
    content => $content,
    # For the default parent directory
    require => Package['openvpn'],
  }

}

