# for template recipe
default['iptables']['addrule']['port_and_ips_for_accept'] = {
    '54321' => ['192.168.56.0/24']
}
default['iptables']['addrule']['service_script'] = "/etc/init.d/iptables"
default['iptables']['addrule']['conf'] = "/etc/init.d/iptables"
