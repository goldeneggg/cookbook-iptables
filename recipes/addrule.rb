# this recipe is template for adding rule of iptables in each cookbooks

service "iptables" do
    supports :restart => true, :status => true
    action :nothing
end

node['iptables']['addrule']['port_and_ips_for_accept'].each do |port, ip_list|
    ip_list.each do |ip|
        execute "add_accept_rule_#{ip}_#{port}" do
            user "root"
            command "iptables -t filter -I INPUT -p tcp -s #{ip} --dport #{port} -j ACCEPT"
            not_if "grep #{ip} #{node['iptables']['rule_file']} | grep #{port}"
        end
    end
end

execute "save_iptables" do
    user "root"
    command "#{node['iptables']['addrule']['service_script']} save"
    notifies :restart, "service[iptables]", :immediately
end
