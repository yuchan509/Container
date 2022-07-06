# Container


## Windows ȯ�濡�� Linux ��ġ

[WSL2](https://docs.microsoft.com/ko-kr/windows/wsl/install) :
WSL(Windows Subsystem for Linux)�� ���� ������ 10���� ����Ƽ��� Linux ���� ������ �����ϱ� ���� ȣȯ�� �����̸�, WSL2�� �� ��° ��������?WSL2�� �ִ� Ư¡���δ� ���� �ӽ�(Virtual Machine)�� ����ؼ� Linux Ŀ���� �����ϴ� "���� Linux ȯ��"�� ����.
<br>

```powershell
# 1�ܰ�. : Linux�� windows ���� �ý��� �ɼ� �̿�.
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# 2�ܰ�. WLS2 ������ ���� �䱸���� Ȯ��.

# 3�ܰ�. Virtual Machine ��� ���.
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# 4�ܰ�. Linux Ŀ�� ������Ʈ ��Ű�� �ٿ�ε�.
- x64 �ӽſ� �ֽ� WSL2 Linux Ŀ�� ������Ʈ ��Ű��(.msi)

# 5�ܰ�. WSL2�� �⺻ �������� ����.
wsl --set-default-version 2

# 6�ܰ� - ������ Linux ���� ��ġ.
- Microsoft Store�� ���� ��� ã�� Linux ������ ����.
- Ubuntu ��ġ.(username/password)
- ��Ű�� ������Ʈ : sudo apt update && sudo apt upgrade
- Windows Terminal ��ġ.(���û���)
```

## Doker ��ġ �� �ǽ�

|<center>Option|<center>Description|
|:---:|:---:|
|`-d`|��׶��� ���(���� ���μ���)|
|`-p`|�����̳��� Port�� ȣ��Ʈ�� ����|
|`-v`|������ ������ ����, ȣ��Ʈ�� �����̳��� ���丮�� �����Ͽ�, ������ �����̳ʿ� �������� �ʰ� ȣ��Ʈ�� �ٷ� ����(mount)|
|`-e`|ȯ�� ������ ������ ����|
|`-i`|interactive : �����̳ʿ� ��ȣ������ �ְ� ����. �Է¿� ���� ����� ��Ÿ���� ��. (t�� ���� ���, ǥ���Է��� Ȱ��ȭ��Ű��, �����̳ʿ� ����Ǿ����� �ʴ��� ǥ���Է��� ����)|
|`-t`|tty(:������ ����̽� ����̺��߿��� �ܼ��̳� �͹̳�)��� �ǹ̷� �͹̳ΰ� ����� ȯ���� ��������. (-i �ɼǰ� �Բ� ����ؾ��ϸ�, bash�� ����ϱ� ���� �ʿ�)|
|`--it`|-i �� -t �Բ� ���|
|`--rm`|�����̳� ������ �ڵ� ����|
|`--restart`|�����̳� �����|


```linux

# ���� nginx image�� ����Ͽ� web ���� ����.
# http://localhost:8000���� �̵��Ͽ� Ȯ��.

$ docker run -it --rm -d -p 8000:80 --name uchan nginx

$ docker stop uchan

# local ���丮�� work ���� ���� �� index.html ����.
$ cd /mnt/c/work ��� �̵� �� Ȯ��.

# index.html ����.
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Hello World</title>
</head>
<body>
  <h2>Hello from Nginx container</h2>
</body>
</html>

# local ���丮�� �����̳ʷ� ���ε� ����Ʈ(mount) ����.
$ docker run -d -p 8000:80 -v /mnt/c/work:/usr/share/nginx/html nginx

# nginx image build

# �⺻ �̹����� Ȱ���Ͽ� ����� ���� �̹��� ������ ����. 
# -> �̹����� ���÷� �������� �� ���� ����� ���� �̹��� ����.
FROM nginx:latest 

# index.html ������ �����̳� ������ ���丮�� �ְ� �̹������� usr/share/nginx/html/index.html �����ϴ� �⺻ index.html ������ ���.
COPY ./index.html/usr/share/nginx/html/index.html

 docker build -t buildedImage

���� �����̳ʿ��� �̹����� ������ �� ������ �̹����� html�� �����ϱ� ���� ���ε� ����Ʈ�� ���� �ʿ䰡 �����ϴ�.
 docker run -it --rm -d -p 8000:80 --name uchan buildedImage
```