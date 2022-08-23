## Env Setting in unbuntu

- Vmware 설치 필수(기타 가상머신 활용 가능)
- Docker, Docker-Compose, kubectl, kustomize, minikube 설치 

## Vmware 설치 및 환경 설정

## 환경 구성(Docker, Docker-Compose, kubectl, kustomize, minikube)
- 

``` shell
uchan@uchan-virtual-machine:~$ docker ps

[error]
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied

# solution  (권한 부여)
$ sudo chmod 666 /var/run/docker.sock

```
```shell
# 목록 확인
ls

# shell script 만들기.
$ cat > {shell script name}.sh

# 권한 부여.
$ chmod u+x {shell script name}.sh

# 스크립트 실행.
$ ./{shell script name}.sh
```
