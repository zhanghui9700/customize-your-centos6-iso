Summary:       eayun-mirrors
Name:          eayun-mirrors
Version:       0.01
Release:       1
Source0:       eayun-mirrors.repo
Group:         Applications/Internet
License:       GPLv2+
URL:           http://www.eayun.cn
#BuildRoot:     %{_tmppath}/%{name}-%{version}-root
BuildArch:     noarch

%description
The eayun-mirrors yum repo
#%prep
#%setup -q
%install
mkdir -p $RPM_BUILD_ROOT/etc/yum.repos.d
install -m 0644 -p %{SOURCE0} $RPM_BUILD_ROOT/etc/yum.repos.d

%clean
rm -rf ${RPM_BUILD_ROOT}
%files
/etc/yum.repos.d/eayun-mirrors.repo
