class ss_osquery::config inherits ::ss_osquery {

    file { '/etc/osquery/osquery.conf':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('ss_osquery/osquery.conf.erb'),
        require => Package['osquery'],
    }
    -> file { '/etc/osquery/osquery.flags':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('ss_osquery/osquery.flags.erb'),
        require => Package['osquery'],
    }
    -> service { 'osqueryd':
        ensure     => true,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require    => Package['osquery'],
        subscribe  => [File['/etc/osquery/osquery.conf'], File['/etc/osquery/osquery.flags']],
    }

    file { '/etc/rsyslog.d/osquery.conf':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///modules/ss_osquery/rsyslogd.conf',
        require => Package['osquery'],
        notify  => Service['rsyslog'],
    }

}
