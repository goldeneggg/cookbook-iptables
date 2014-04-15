#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# customize iptables
execute "stash_org_iptables" do
    user "root"
    command "cp -p #{node['iptables']['rule_file']} #{node['iptables']['org_rule']}"
    only_if "ls #{node['iptables']['rule_file']}"
    not_if "ls #{node['iptables']['org_rule']}"
end

service "iptables" do
    supports :restart => true, :status => true
    action :nothing
end

template "#{node['iptables']['rule_file']}" do
    source "iptables.erb"
    mode 0600
    owner "root"
    group "root"
    notifies :restart, "service[iptables]", :immediately
    only_if "diff #{node['iptables']['org_rule']} #{node['iptables']['rule_file']}"
end

# stop unnecessary services
node['iptables']['stop_services'].each do |srv|
    service srv do
        action :stop
        only_if "service #{srv} status"
    end

    execute "#{srv}_off" do
        command "chkconfig #{srv} off"
        only_if "chkconfig --list | grep #{srv} | grep 3:on"
    end
end

# test
#include_recipe "cookbook-iptables::addrule"
