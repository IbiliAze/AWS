Chef::Log.info("#### Setup Executed ####")

user "Add a User" do
  home "/home/ibi"
  shell "/bin/bash"
  username "ibi"
end

directory "Create a log Directory"
  group "root"
  mode "0777"
  owner "ec2-user"
  path "/var/log/customapp"
end
