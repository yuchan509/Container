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
## Docker 컨테이너 라이프사이클
`도커 버전 확인`
```linux
$ docker -v
```
`실행 중인 컨테이너 확인`
```linux
$ docker ps
$ docker ps -a # 전체 컨테이너 목록 확인(중지된 것 포함)
$ docker inspect [container id or name] # 컨테이너 상세 정보 확인.
```

! Docker create / run 명령어 모두 Image가 존재하지 않을 경우, 자동으로 pull을 먼저 수행하여 Image 다운로드 받음.

`컨테이너 생성`
```linux
$ docker create [image]
# b9fb79c7770edd1d86bbfa3dd4730d3a7844a9c3ab98eb640f461a7a8a239041(hash) 생성됨. 
```

`컨테이너 시작`
```linux
$ docker start [container]
```

`컨테이너 생성 및 시작`
```linux
$ docker run [image]
```

`컨테이너 일시중지`
```linux
$ docker pause [container]
```

`컨테이너 재개`
```linux
$ docker unpause [container]
```

`컨테이너 종료(SIGTERM 시그널 전달)`
```linux
$ docker stop [container]
```

`컨테이너 강제 종료(SIGKILL 시그널 전달)`
```linux
$ docker kill [container]
```

`모든 컨테이너 강제 종료(SIGKILL 시그널 전달)`
```linux
$ docker stop $(docker ps -a -q)
```

`컨테이너 삭제(실행 중인 컨테이너 불가)`
```linux
$ docker rm [container]
```

`컨테이너 강제 종료 후 삭제(SIGKILL 시그널 전달)`
```linux
$ docker rm -f [container]
```

`컨테이너 실행 종료 후 자동 삭제`
```linux
$ docker run --rm ...
```

`중지된 모든 컨테이너 삭제`
```linux
$ docker container prune
```



## Doker 설치 및 실습

`이미지(Image)` : 이미지는 컨테이너를 생성할 때 필요한 요소로 컨테이너의 목적에 맞는 바이너리와 의존성이 설치되어 있음. 여러 개의 계층으로 된 바이너리 파일로 존재.

`이미지 저장소(Image Repository)` : 도커 이미지를 관리하고 공유하기 위한 서버 어플리케이션. (e.g. dockerhub, AWS ECR, docker Registry, quay)

`컨테이너(Container)` : 호스트와 다른 컨테이너로부터 격리된 시스템 자원과 네트워크를 사용하는 프로세스. 이미지는 일기 전용으로만 사용되어 변경사항은 컨테이너 계층에 저장. --> 컨테이너에서 무엇을 하든 이미지에 영향을 끼치지 않음.

|<center>Option|<center>Description|
|:-----:|:---|
|`-d`|백그라운드 모드로(데몬 프로세스) 실행|
|`-p`|컨테이너의 Port를 호스트와 연결(호스트 - 컨테이너 간 포트 바인딩)|
|`-v`|데이터 볼륨을 설정, 호스트와 컨테이너의 디렉토리를 연결하여, 파일을 컨테이너에 저장하지 않고 호스트에 바로 저장(호스트 - 컨테이너 간 볼륨 바인딩)|
|`-e`|환경 변수의 설정이 가능|
|`-i`|interactive : 컨테이너와 상호적으로 주고 받음. 입력에 대한 출력을 나타내는 말. (t와 같이 사용, 표준입력을 활성화시키며, 컨터이너와 연결되어있지 않더라도 표준입력을 유지)|
|`-t`|tty(:리눅스 디바이스 드라이브중에서 콘솔이나 터미널)라는 의미로 터미널과 비슷한 환경을 조성해줌. (-i 옵션과 함께 사용해야하며, bash를 사용하기 위해 필요)|
|`--it`|-i 와 -t 함께 사용|
|`--name`|컨테이너 이름 지정, 미정시 자동 생성|
|`--rm`|컨테이너 정지시 자동 삭제|
|`--restart`|컨테이너 재시작|
|`ctrl +  p + q`|실행 중인 상태에서 벗어남|

<br>
  
```linux

# 공식 nginx image를 사용하여 web 서버 구동.
# http://localhost:8000으로 이동하여 확인.

$ docker run -it --rm -d -p 8000:80 --name uchan nginx
$ curl localhost:8000

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

