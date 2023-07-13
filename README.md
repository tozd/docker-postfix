# tozd/postfix

<https://gitlab.com/tozd/docker/postfix>

Available as:

- [`tozd/postfix`](https://hub.docker.com/r/tozd/postfix)
- [`registry.gitlab.com/tozd/docker/postfix`](https://gitlab.com/tozd/docker/postfix/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/dinit`](https://gitlab.com/tozd/docker/dinit) ← `tozd/postfix`

## Tags

- `ubuntu-trusty`: Postfix 2.11.0
- `ubuntu-xenial`: Postfix 3.1.0
- `ubuntu-bionic`: Postfix 3.3.0
- `ubuntu-focal`: Postfix 3.4.13
- `ubuntu-jammy`: Postfix 3.6.4
- `alpine-38`: Postfix 3.3.0
- `alpine-310`: Postfix 3.4.7
- `alpine-312`: Postfix 3.5.16
- `alpine-314`: Postfix 3.6.4
- `alpine-316`: Postfix 3.7.6

## Description

Docker image providing [Postfix](http://www.postfix.org/).

You should make sure you mount spool volume (`/var/spool/postfix`) so that you do not
lose e-mail data when you are recreating a container. If a volume is empty, image
will initialize it at the first startup.

By default it is configured for sending outbound e-mails. Otherwise, you can extend
the image and configure it differently. See these examples:

- [cloyne/postfix](https://github.com/cloyne/docker-postfix), which extends it to integrate
  it with [tozd/sympa](https://gitlab.com/tozd/docker/sympa) mailing lists service
- [tozd/mail](https://gitlab.com/tozd/docker/mail), which extends it to provide a full-fledged
  e-mail service with virtual users

Remember that for the best e-mail delivery external IP should match the hostname it resolves to.
You might find [tozd/external-ip](https://gitlab.com/tozd/docker/external-ip) Docker image useful
for this.

If you are extending this image, you can add two scripts which will be run at a container startup:

- `/etc/service/postfix/run.config` – to prepare any custom configuration, before anything else is run
- `/etc/service/postfix/run.initialization` – will be run after the container is initialized, but before the
  Postfix daemon is run

If you just need programs inside your Docker images to send e-mails using `sendmail` program
locally, consider using [tozd/mailer](https://gitlab.com/tozd/docker/mailer) or
[tozd/nginx-mailer](https://gitlab.com/tozd/docker/nginx-mailer) Docker image as your base.
This `tozd/postfix` Docker image delivers e-mails to wide Internet by itself.
Then you can configure `tozd/mailer`-based containers to relay e-mails to one `tozd/postfix`
container which then sends e-mails out.

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-postfix),
if you need to fork the project there.
