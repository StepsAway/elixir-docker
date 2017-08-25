FROM stepsaway/baseimage:##TAG##
MAINTAINER StepsAway <devgru@stepsaway.com>

COPY . /elixir_build
RUN /elixir_build/install.sh

CMD ["/sbin/my_init"]
