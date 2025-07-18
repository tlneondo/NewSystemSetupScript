sudo gedit /etc/yum.repos.d/koji.repo
[koji]
name=Koji $basearch
baseurl=https://kojipkgs.fedoraproject.org/repos/rawhide/latest/$basearch/
enabled=1
#metadata_expire=60m
gpgcheck=0
