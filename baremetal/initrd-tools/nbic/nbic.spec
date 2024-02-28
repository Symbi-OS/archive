Name:      nbic
Summary:   Net Boot Image Compiler
Version:   0.3.0
Release:   1
Group:     System/Base
License:   IBM Proprietary
URL:       http://yktgsa.ibm.com/home/a/w/awaterl/pub/kittyhawk/nbic/
Source0:   http://yktgsa.ibm.com/home/a/w/awaterl/pub/kittyhawk/nbic/%{name}-%{version}.tar.gz
Requires:  rsync
Buildroot: %{_tmppath}/%{name}-%{version}-buildroot

%description
The nbic tools automate the process of building stripped-down root
filesystems for Linux on diskless compute nodes.

%prep
%setup

%build
# All shell.  Nothing to do

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT PREFIX=/usr

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{_bindir}/cpio-*
%{_bindir}/nbic
%{_bindir}/nd
%{_bindir}/trace-files

%changelog
*Mon Feb 25 2008 Josh Boyer <jwboyer@linux.vnet.ibm.com>
- Add requires on rsync

*Thu Feb 21 2008 Josh Boyer <jwboyer@linux.vnet.ibm.com>
- Create initial spec file
