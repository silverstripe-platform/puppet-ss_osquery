class ss_osquery (
) {
    class { 'ss_osquery::install': }
    -> class { 'ss_osquery::config': }
}
