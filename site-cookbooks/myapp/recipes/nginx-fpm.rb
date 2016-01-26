#
# Cookbook Name:: myapp
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(web logs).each do |dir|
  directory "#{node.app.web.application_root}/#{dir}" do
    #owner node.user.name
    mode "0755"
    recursive true
  end
end

template "#{node.nginx.dir}/sites-available/localarea" do
  source "site.conf.erb"
end

nginx_site "localarea"

#service 'nginx' do
#  action :restart
#end

#cookbook_file "#{node.app.web.application_root}/web/index.html" do
#  source "index.html"
#  mode 0755
#  #owner node.user.name
#end
