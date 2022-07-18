# `@atomist/skill-base`

Docker base image for JavaScript/TypeScript based Atomist skills.

## Usage

Use the following `FROM` line in your Dockerfile:

```
FROM atomist/skill:alpine_3.16-node_16
```

The `atomist/docker-base-image-policy` can pin the `FROM` to latest digests of
this tag.

Deprecated tags:

-   `node16`

---

Created by [Atomist][atomist]. Need Help? [Join our Slack workspace][slack].

[atomist]: https://atomist.com/ "Atomist"
[slack]: https://join.atomist.com/ "Atomist Community Slack"
