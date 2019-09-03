class ss_osquery::install inherits ::ss_osquery {

    ensure_packages(['apt-transport-https', 'lsb-release', 'ca-certificates'], {'ensure' => 'present'})

    if ($http_proxy == '') {
        apt::key { 'osquery':
            id     => '1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B',
            server => 'keyserver.ubuntu.com',
        }
    } else {
        apt::key { 'osquery':
            id      => '1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B',
            server  => 'hkp://keyserver.ubuntu.com:80',
            options => "http-proxy=${http_proxy}",
        }
    }

    apt::source { 'osquery':
        location    => 'https://pkg.osquery.io/deb',
        release     => 'deb',
        repos       => 'main',
        include_src => false,
        require     => [
            Apt::Key['osquery'],
            Package['apt-transport-https', 'lsb-release', 'ca-certificates']
        ],
    }
    -> package { 'osquery':
        ensure  => $ensure,
        require => Class['::apt::update']
    }

}
