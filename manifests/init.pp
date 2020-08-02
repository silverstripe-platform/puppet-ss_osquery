class ss_osquery (
    $config_object = {},
) {
    class { 'ss_osquery::install': }
    -> class { 'ss_osquery::config': }
}
