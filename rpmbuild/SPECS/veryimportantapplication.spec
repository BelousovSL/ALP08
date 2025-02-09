Name:           veryimportantapplication
Version:        1
Release:        1.ro8
Summary:        VeryImportantApplication
Packager:       Otus
Group:          System Environment/libraries
Requires:       aspnetcore-runtime-6.0
License:        ParusYug

%description
Belousov student's test case. Responds to GET request /Information

%prep

%build

%install
%{__mkdir} -p %{buildroot}/etc/systemd/system
%{__mkdir} -p %{buildroot}/opt/belousov/%{name}
%{__mkdir} -p %{buildroot}/etc/%{name}
%{__cp} -r %{_builddir}/%{name} %{buildroot}/opt/belousov/
%{__cp} %{_builddir}/%{name}.service %{buildroot}/etc/systemd/system/
%{__ln_s} /opt/belousov/%{name}/appsettings.json %{buildroot}/etc/%{name}/appsettings.json

%files
/opt/belousov/%{name}
/etc/systemd/system/%{name}.service
/etc/%{name}/appsettings.json

%changelog
