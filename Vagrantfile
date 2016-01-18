VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu-14.04-amd64-vbox"
    config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
    config.vm.network :public_network, ip:'192.168.10.100'
    config.vm.provider :virtualbox do |vm|
        vm.name = "web_vm"
    end
    
    if Vagrant.has_plugin?('vagrant-berkshelf')
        config.berkshelf.enabled = false
    end
    
    # config.ssh.private_key_path = ['~/.vagrant.d/ssh/id_rsa']
    
    config.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.vagrant.d/ssh/id_rsa.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
      SHELL
    end
    
    config.vm.provision :chef_zero do |chef|
        chef.cookbooks_path = ["cookbooks" , "site-cookbooks"]
        
        chef.add_recipe "nginx"
        chef.add_recipe "php"
        chef.add_recipe "php-fpm"
        chef.add_recipe "myapp"
        
        chef.json = {
            "php-fpm" => {
                "pools" => {
                    "default" => {
                        :enable => true
                    },
                    "www" => {
                        :enable => "true",
                        :process_manager => "dynamic",
                        :max_requests => 5000,
                        :php_options => { 'php_admin_flag[log_errors]' => 'on', 'php_admin_value[memory_limit]' => '32M' }
                    }
                }
            },
                "app" => {
                    "web_dir" => '/vagrant/www'
                }
        }
        chef.run_list = [
            "recipe[nginx]",
            "recipe[php]",
            "recipe[php-fpm]",
            "recipe[myapp::nginx-fpm]"
        ]
    end
end
