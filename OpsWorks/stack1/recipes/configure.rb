Chef::Log.info("#### Configure Executed ####")

package "Install Apache" do
  package_name "httpd"
end

package "Install PHP" do
  package_name "php"
end

service "Start HTTPD" do
  action :start
  service_name "httpd"
end

service "Enable HTTPD" do
  action :enable
  service_name "httpd"
end

cookbook_file "Install Website Files" do
  group "root"
  mode "0777"
  owner "root"
  path "/var/www/html/index.php"
  source "index.php"
end
