#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2015, dolpen.net
#
# All rights reserved - Do Not Redistribute
#

# ~/.sshを掘る
directory '/home/dolpen/.ssh' do
  owner  'dolpen'
  group  'dolpen'
  mode   '0755'
  action :create
end

# ~/.ssh/authorized_keys に公開鍵を書き込む
cookbook_file '/home/dolpen/.ssh/authorized_keys' do
  source 'authorized_keys'
  owner  'dolpen'
  group  'dolpen'
  mode   '0644'
  action :create
end

# sshdのサービス定義
service 'sshd' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

# sshd設定更新とリロード
cookbook_file '/etc/ssh/sshd_config' do
  source 'sshd_config'
  owner  'root'
  group  'root'
  mode   '0600'
  notifies :reload, 'service[sshd]'
end

# webサーバーがローカルプロキシできない問題
execute 'nginx_can_proxy_self' do
  not_if "getsebool httpd_can_network_connect | awk {'print $3'} | egrep -qx 'on'"
  command 'setsebool -P httpd_can_network_connect 1'
  action :run
end

# サーバー名
template '/etc/sysconfig/network' do
  source 'network.erb'
  mode 0644
  user 'root'
  group 'root'
end

# 時刻

file "/etc/localtime" do
  content IO.read("/usr/share/zoneinfo/Japan")
  owner  'root'
  group  'root'
  mode   '0644'
  action :create
end

file '/etc/sysconfig/clock' do
  content 'ZONE="Asia/Tokyo"'
  owner  'root'
  group  'root'
  mode   '0644'
  action :create
end

# security update

package 'yum-fastestmirror' do
  action :upgrade
end

execute 'yum-update' do
  user 'root'
  command 'yum -y update'
  action :run
end

update_packages = %w[
  glibc
  sysstat
]

update_packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end


#ふようなさーびすをとめる

off_services = %w[
  blk-availability
  bluetooth
  certmonger
  cpuspeed
  cups
  haldaemon
  ip6tables
  iscsi
  iscsid
  lvm2-monitor
  mdmonitor
  messagebus
  netfs
  nfslock
  postfix
  rpcbind
  rpcgssd
  rpcidmapd
  udev-post
]

off_services.each do |service|
  bash "stop_#{service}_service" do
    only_if "chkconfig --list | grep #{service} | grep 3:on"
    code <<-EOS
      chkconfig #{service} off
    EOS
  end
end
