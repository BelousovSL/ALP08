# Название выполняемого задания;
Сборка RPM-пакета и создание репозитория

# Текст задания
создать свой RPM (можно взять свое приложение, либо собрать к примеру Apache с определенными опциями);
cоздать свой репозиторий и разместить там ранее собранный RPM;
реализовать это все либо в Vagrant, либо развернуть у себя через Nginx и дать ссылку на репозиторий.

# Реализация
Я пошел путем создание простейшего приложения на DotNet. Имеющий поддержку REST GET /Information. Запихнул его в пакет veryimportantapplication. На этом же сервере создал репозиторий. И в нем же развернул свой новый пакет вместе с зависимостью. С хостовой машины через ssh "дернул" rest "ручку".

## Шаги
- Прибиндил каталог rpmbuild. Из интересного в нем. 

### Каталог rpmbuild/BUILD:
1) Каталог с бинарниками приложения
1) Файл сервиса

### Каталог rpmbuild/SPEC:
Фаил veryimportantapplication.spec
```code
Name:           veryimportantapplication
Version:        1
Release:        1.ro8
Summary:        VeryImportantApplication
Packager:       Otus
Group:          System Environment/librariesКрастное 
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
```

### Каталог nginx
В нем находится nginx.conf

Все подробности в init.sh

Запускаем все vagrant up.

Результат
```
sergey@fedora:~/Otus/homework/08/ALP08/rpmbuild$ ssh vagrant@127.0.0.1 -p 2222 "sh -c 'curl http://127.0.0.1:5000/Information'"
vagrant@127.0.0.1's password: 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    98    0    98    0     0  98000 Привет Мир!-:-- --:--:-- --:--:--     0
Тестовый сервис, студента Otus
Белоусов С.Л.
     0 --:--:-- --:--:-- --:--:-- 98000
```

