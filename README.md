# Container


## Windows 환경에서 Linux 설치

[WSL2](https://docs.microsoft.com/ko-kr/windows/wsl/install) :
WSL(Windows Subsystem for Linux)의 약어로 윈도우 10에서 네이티브로 Linux 실행 파일을 실행하기 위한 호환성 계층이며, WSL2는 두 번째 버전으로?WSL2의 최대 특징으로는 가상 머신(Virtual Machine)을 사용해서 Linux 커널이 동작하는 "실제 Linux 환경"을 제공.
<br>

```powershell
# 1단계. : Linux용 windows 하위 시스템 옵션 이용.
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# 2단계. WLS2 실행을 위한 요구사항 확인.

# 3단계. Virtual Machine 기능 사용.
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# 4단계. Linux 커널 업데이트 패키지 다운로드.
- x64 머신용 최신 WSL2 Linux 커널 업데이트 패키지(.msi)

# 5단계. WSL2를 기본 버전으로 설정.
wsl --set-default-version 2

# 6단계 - 선택한 Linux 배포 설치.
- Microsoft Store를 열고 즐겨 찾는 Linux 배포를 선택.
- Ubuntu 설치.(username/password)
- 패키지 업데이트 : sudo apt update && sudo apt upgrade
- Windows Terminal 설치.(선택사항)
```

## Doker 설치 및 실습

|<center>Option|<center>Description|
|:-----:|:---|
|`-d`|백그라운드 모드(데몬 프로세스)|
|`-p`|컨테이너의 Port를 호스트와 연결|
|`-v`|데이터 볼륨을 설정, 호스트와 컨테이너의 디렉토리를 연결하여, 파일을 컨테이너에 저장하지 않고 호스트에 바로 저장(mount)|
|`-e`|환경 변수의 설정이 가능|
|`-i`|interactive : 컨테이너와 상호적으로 주고 받음. 입력에 대한 출력을 나타내는 말. (t와 같이 사용, 표준입력을 활성화시키며, 컨터이너와 연결되어있지 않더라도 표준입력을 유지)|
|`-t`|tty(:리눅스 디바이스 드라이브중에서 콘솔이나 터미널)라는 의미로 터미널과 비슷한 환경을 조성해줌. (-i 옵션과 함께 사용해야하며, bash를 사용하기 위해 필요)|
|`--it`|-i 와 -t 함께 사용|
|`--rm`|컨테이너 정지시 자동 삭제|
|`--restart`|컨테이너 재시작|

<br>
  
```linux

# 공식 nginx image를 사용하여 web 서버 구동.
# http://localhost:8000으로 이동하여 확인.

$ docker run -it --rm -d -p 8000:80 --name uchan nginx

$ docker stop uchan

# local 디렉토리에 work 폴더 생성 및 index.html 생성.
$ cd /mnt/c/work 경로 이동 및 확인.

# index.html 구성.
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

# local 디렉토리를 컨테이너로 바인딩 마운트(mount) 볼륨.
$ docker run -d -p 8000:80 -v /mnt/c/work:/usr/share/nginx/html nginx

# nginx image build

# 기본 이미지를 활용하여 사용자 지정 이미지 구축을 시작. 
# -> 이미지를 로컬로 가져오고 그 위에 사용자 지정 이미지 빌드.
FROM nginx:latest 

# index.html 파일을 컨테이너 내부의 디렉토리에 넣고 이미지에서 usr/share/nginx/html/index.html 제공하는 기본 index.html 파일을 덮어씀.
COPY ./index.html/usr/share/nginx/html/index.html

 docker build -t buildedImage

이제 컨테이너에서 이미지를 실행할 수 있지만 이번에는 html을 포함하기 위해 바인드 마운트를 만들 필요가 없습니다.
 docker run -it --rm -d -p 8000:80 --name uchan buildedImage
```
