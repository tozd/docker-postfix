Image providing [Postfix](http://www.postfix.org/) as a service.

You should make sure you mount spool volume (`/var/spool/postfix`) so that you do not
lose e-mail data when you are recreating a container. If a volume is empty, image
will initialize it at the first startup.

By default it is configured for sending outbound e-mails. Otherwise, you can extend
the image and configure it differently. See these examples:
 * [cloyne/postfix](https://github.com/cloyne/docker-postfix), which extends it to integrate
   it with [tozd/sympa](https://github.com/tozd/docker-sympa) mailing lists service
 * [tozd/mail](https://github.com/tozd/docker-mail), which extends it to provide a full-fledged
   e-mail service with virtual users

Remember that for the best e-mail delivery external IP should match the hostname it resolves to.

If you are extending this image, you can add two scripts which will be run at a container startup:
 * `/etc/service/postfix/run.config` – to prepare any custom configuration, before anything else is run
 * `/etc/service/postfix/run.initialization` – will be run after the container is initialized, but before the
   Postfix daemon is run
