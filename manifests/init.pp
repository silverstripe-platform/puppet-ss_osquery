class ss_osquery (
    $http_proxy = '',
) {
    class { 'ss_osquery::install': }
    -> class { 'ss_osquery::config': }
}
