# docker-ntopng
This is a new way to dockerize ntopng products, unlike lucaderi/ntopng-docker, this repository has been built from a fresh source code and not from a debian package.

# How to use s4l3h1/docker-ntopng ?

You can use it simply by run:

```
docker run -d --net=host s4l3h1/docker-ntopng
```

If you want to get a mirror of some network interface and you do not want to attach that to docker container, Just do as follow:
```
$ docker run -d --net=host --name ntopng -p3000:3000 s4l3h1/docker-ntopng
$ git clone github.com/salehi/docker-sciprts
$ sudo cp -rfv docker-scripts/bin/* /usr/bin/
$ ./docker-scipts/docker-add-veth.sh ntopng
$ sudo tc qdisc add dev eth1 ingress
$ sudo tc filter add dev eth1 parent ffff: protocol all u32 match u8 0 0 action mirred egress mirror dev ntopn-eth1
```
Note: replace eth1 in last two commands with your desired interface.
