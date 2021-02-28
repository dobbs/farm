# Release Notes for 1.0.0

This is a significant **breaking** change from pre-1.0 releases. Especially:

* changed the user from `app` (`uid=1001(app) gid=1001(app) groups=1001(app)`)
  to `node` (`uid=1000(node) gid=1000(node) groups=1000(node),1000(node)`)

* no longer installing `bash`, `configure-wiki`, nor `set-owner-name`

* no longer creating `/home/app/.wiki/wiki.json`

Those changes in particular will impose some work on authors upgrading
from previous versions.

The last non-breaking revision is 0.52.0 https://github.com/dobbs/farm/tree/0.52.0#readme
