class ss_osquery (
    $version = '',
    $http_proxy = '',
) {
    class { 'ss_osquery::install': }
    -> class { 'ss_osquery::config': }
}
