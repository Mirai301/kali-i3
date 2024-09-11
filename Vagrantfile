Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"

    config.vm.provider "vmware_desktop" do |vmware|
        vmware.gui = true
        vmware.memory = 4096
        vmware.cpus = 4
        vmware.vmx["mks.enable3d"] = "TRUE"
    end

    config.vm.provision :ansible_local do |ansible|
        ansible.playbook = "playbook.yml"
        ansible.verbose = true
        ansible.install = true
        ansible.limit = "all"
        # ansible.become = true
    end
end