# VirtualBox
# Vagrant.configure("2") do |config|
#     config.vm.box = "kalilinux/rolling"
#     config.vm.provider "virtualbox" do |vb|
#         vb.name = "kali-i3"
#         vb.gui = true
#         vb.memory = 4096
#         vb.cpus = 4
#         vb.linked_clone = false
#         vb.customize = [
#             "--accelerate3D": "true",
#             "--VRAMSize": "256",
#         ]
#     end

# VMWare-Provider
Vagrant.configure("2") do |config|
    config.vm.box = "kalilinux/rolling"
    config.vm.disk :disk, size: "100GB", primary: true
      config.vm.provider "vmware_desktop" do |vmware|
          vmware.gui = true
          vmware.memory = 4096
          vmware.cpus = 4
          vmware.vmx["mks.enable3d"] = "TRUE"
      end

    # PYTHONUNBUFFERED=1 ansible-playbook --limit="all" --inventory-file=/inventory -v playbook.yml -u vagrant
    config.vm.provision :ansible_local do |ansible|
        ansible.playbook = "playbook.yml"
        ansible.verbose = true
        ansible.install = true
        ansible.limit = "all"
        # ansible.become = true
        ansible.extra_vars = {
            ansible_user: "vagrant"
        }
    end
end