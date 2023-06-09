# debian-systemd

Debian image with systemd for use with ansible.

Molecule example:

```
driver:
  name: docker
platforms:
  - name: stretch
    image: tatsuryu/debian-systemd-molecule
    dockerfile: Dockerfile
    privileged: True
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    command: /lib/systemd/systemd
```

```TAGS```
----

**```9```**: Stretch version
**```10```**: Buster version
**```11```**: Bullseye version

# Goals

1. [Fix apt Errors](#Prevents)
2. [Fix TestInfra Service Errors](#Permits)

## Prevents *invoke-rc.d: policy-rc.d denied execution* errors on apt install.
```
echo "exit 0" > /usr/sbin/policy-rc.d
```

## Permits TestInfra to acknowledge this Docker image as systemd.
```
ln -s /lib/systemd/systemd /sbin/init
```
