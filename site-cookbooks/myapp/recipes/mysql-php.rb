mysql_service 'default' do
  version '5.5'
  port '3306'  
  initial_root_password node['app']['mysql']['server_root_password']
  action [:create, :start]
end

mysql_client 'default' do
  action :create
end

# Externalize conection info in a ruby hash
mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['app']['mysql']['server_root_password'],
  #:socket   => "/var/run/mysql-default/mysqld.sock"
  :socket   => "/run/mysql-default/mysqld.sock"
}

gem_package 'mysql2' do
    gem_binary RbConfig::CONFIG['bindir'] + '/gem'
    action :install
end

# Create a mysql database on a named mysql instance
database  node['app']['mysql']['connect_database'] do
  connection mysql_connection_info
  provider   Chef::Provider::Database::Mysql
  action :create
end

# mysql user
mysql_database_user node['app']['mysql']['connect_user'] do
  connection    mysql_connection_info
  username      node['app']['mysql']['connect_user']
  password      node['app']['mysql']['connect_password']
  database_name node['app']['mysql']['connect_database']
  privileges    [:all]
  action        [:create , :grant]
end

