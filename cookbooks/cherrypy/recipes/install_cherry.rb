yum_package 'php'do
    action :install
end
yum_package "php-pgsql" do
    action :install
end
execute 'pg' do
 command 'yum localinstall http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-2.noarch.rpm -y'
end

yum_package 'postgresql94' do
 action :install
end

bash "install cherrypy" do
	user "root"
	code <<-EOH
	curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
	sudo python get-pip.py
	sudo pip install CherryPy
	EOH
end

yum_package 'python-psycopg2.i686'do
    action :install
end

bash "open port" do
	user "root"
	code <<-EOH
	iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
	service iptables save
	EOH
end

template "/home/vagrant/server.py" do
	source "server.py"
	mode 0644
	owner "root"
	group "wheel"
	variables({
		:ip_database => "#{node[:aptmirror][:databaseip]}",
		:ip_server => "#{node[:aptmirror][:serverip]}",
                :port_server => "#{node[:aptmirror][:serverport]}"
	})
end

cookbook_file "/etc/init/micro_service.conf" do
	source "micro_service.conf"
	mode 0644
	owner "root"
	group "wheel"
end

bash "server execute" do
	user "root"
	code <<-EOH
	start micro_service
	EOH
end



