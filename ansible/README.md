# Ansible

Build container with specific version of Ansible from https://github.com/ansible/ansible/releases

## Specific version
It will use .tar.gz.
```
docker build --build-arg VERSION=v2.3.1.0-1 .
```

## Master
It will use GIT.
Default version is `master` and `git clone` will be used instead of tar.gz file downloading, then building will be slower and image size will be bigger.
```
docker build .
```
