# Federated Wiki Farm

http://fed.wiki.org

Although this container can run alone, I use and develop it with
a reverse proxy.  See: https://github.com/dobbs/wiki-tls

See also http://local-farm.wiki.dbbs.co for many more details.

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

# Development

This image's tag matches the version of the included wiki software.

Notes to self:

``` bash
git tag -am "" '0.14.0'
git push --tags
```

The repos in Dockerhub and GitHub are configured to automatically build new tags.
