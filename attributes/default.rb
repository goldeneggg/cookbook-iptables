default['iptables']['org_rule'] = "/root/iptables.org"
default['iptables']['rule_file'] = "/etc/sysconfig/iptables"

# for web server in private network
default['iptables']['tcp_accept_port_and_ips'] = {
    '80' => ['192.168.56.0/24']
}
default['iptables']['stop_services'] = ["ip6tables"]

#include_attribute "cookbook-iptables::addrule"
