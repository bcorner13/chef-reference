# use a variable to give the name of the centos box build
#vm_box="bento/centos-7.2"


#node.chef_provisioning['reference'].tap do |reference|
#  reference['ssh_username']='centos'
#end

node.default['chef']['provisioning'].tap do |provisioning|

  provisioning['driver'] = {
    'gems' => [
      {
        'name' => 'chef-provisioning-aws',
        'require' => 'chef/provisioning/aws_driver'
      }
    ],
    'with-parameter' => 'aws:dev:us-east-1'
  }


  provisioning['machine_options'] = {
        'ssh_username' => 'centos',
        'use_private_ip_for_ssh' => true,
        'transport_address_location' => :private_ip,
        'convergence_options' => {
          'bootstrap_proxy' => 'http://internal-dev-squidlb-1691991998.us-east-1.elb.amazonaws.com:3128',
          'bootstrap_no_proxy' => 'localhost'
        },
        'bootstrap_options' => {
          'key_name'=> 'hc-metal-provisioner',
          'image_id'=> 'ami-a7a18bcd',
          'subnet_id'=> 'subnet-21085156',
          'security_group_ids'=> 'sg-10668268',
          'instance_type'=> 'm3.medium'
        }
  }


#  provisioning['server-backend-options'] = {
#    vagrant_config: <<-VC
#      config.vm.provider "vmware_fusion" do |v|
#        v.vmx["memsize"] = "1024"
#        v.vmx["numvcpus"] = "2"
#      end
#
#      config.vm.box = "#{vm_box}"
#      config.vm.network "private_network", ip: "192.168.80.80"
#    VC
#  }
#
#  provisioning['server-frontend-options'] = {
#    vagrant_config: <<-VC
#      config.vm.provider "vmware_fusion" do |v|
#        v.vmx["memsize"] = "1024"
#        v.vmx["numvcpus"] = "2"
#      end
#
#      config.vm.box = "#{vm_box}"
#      config.vm.network "private_network", ip: "192.168.80.81"
#    VC
#  }
#
#  provisioning['analytics-options'] = {
#    vagrant_config: <<-VC
#      config.vm.provider "vmware_fusion" do |v|
#        v.vmx["memsize"] = "1024"
#        v.vmx["numvcpus"] = "2"
#      end
#
#      config.vm.box = "#{vm_box}"
#      config.vm.network "private_network", ip: "192.168.80.82"
#    VC
#  }
#
#  provisioning['supermarket-options'] = {
#    vagrant_config: <<-VC
#      config.vm.provider "vmware_fusion" do |v|
#        v.vmx["memsize"] = "1024"
#        v.vmx["numvcpus"] = "2"
#      end
#
#      config.vm.box = "#{vm_box}"
#      config.vm.network "private_network", ip: "192.168.80.83"
#    VC
#  }
end

include_recipe 'provision::cluster'
