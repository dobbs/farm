# Federated Wiki Farm

http://fed.wiki.org

### Get acquainted with wiki.

Launch the container:
``` bash
docker run -p 3000:3000 -it --rm \
  dobbs/farm
```

Visit http://localhost:3000

### Make your wiki survive a reboot

Create a volume:

``` bash
docker volume create dot-wiki
```

Launch the container:
``` bash
docker run -p 3000:3000 -it --rm \
  -v dot-wiki:/home/app/.wiki \
  dobbs/farm
```

Visit http://localhost:3000

### Make your wiki a local farm

We're going to use http://localtest.me instead of localhost for our
domain name.  See http://readme.localtest.me for more info.

Let's also use a different volume for this one:
``` bash
docker volume create localtest.me
```

Specify the domain name when you launch your wiki
``` bash
docker run -p 3000:3000 -it --rm \
  -v localtest.me:/home/app/.wiki \
  -e DOMAIN=localtest.me \
  dobbs/farm
```

Open http://this.localtest.me:3000 in one tab.
Open http://that.localtest.me:3000 in another.

# Development

This image's tag matches the version of the included wiki software.

``` bash
git tag -am "" '0.12.1+github'
git push --tags
docker build -t dobbs/farm:0.12.1+github .
docker push dobbs/farm:0.12.1+github
```
