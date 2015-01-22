test_name "Hiera setup for YAML backend"

agents.each do |agent|
  apply_manifest_on agent, <<-PP
file { '/etc/hiera.yaml':
  ensure  => present,
  content => '---
    :backends:
      - "yaml"
    :logger: "console"
    :hierarchy:
      - "%{fqdn}"
      - "%{environment}"
      - "global"

    :yaml:
      :datadir: "/etc/puppet/hieradata"
  '
}

file { '/etc/puppet/hieradata':
  ensure  => directory,
  recurse => true,
  purge   => true,
  force   => true,
}
PP
end
