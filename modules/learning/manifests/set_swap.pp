class learning::set_swap {
  augeas { "swap settings":
    context => "/files/etc/sysctl.conf",
    changes => [
      "set vm.overcommit_memory 2",
      "set vm.swapiness 75",
    ],
    before => Class['learning::install'],
  }
}
