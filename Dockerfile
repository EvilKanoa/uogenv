 # socs servers use debian (correctly 9.6)
FROM debian:9.6

# image metadata
LABEL maintainer="EvilKanoa <kanoa@kanoa.ca>"

# setup install env variables
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_FRONTEND noninteractive
ENV TERM xterm

# copy in required files for dep install
COPY config/dpkg-selections /usr/local/bin/dpkg-selections
COPY config/keyboard /etc/default/keyboard
COPY config/console-setup /etc/default/console-setup

# install depsi
RUN apt-get update -y \
	&& apt-get install -y apt-utils \
	&& apt-get install -y \
		dselect dctrl-tools \
		openssh-client openssh-server \
		sudo \
	&& sync-available \
	&& dpkg --clear-selections \
	&& dpkg --set-selections < /usr/local/bin/dpkg-selections \
	&& apt-get dselect-upgrade -y 

# copy in config scripts
COPY config/ssh_config /etc/ssh/ssh_config
COPY config/sshd_config /etc/ssh/sshd_config
COPY script/user.sh /usr/local/bin/user.sh
COPY script/entrypoint.sh /usr/local/bin/entrypoint.sh

# run config scripts
RUN chmod +x /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN /usr/local/bin/user.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# open ports and let container sit
EXPOSE 22/tcp
CMD tail -f /dev/null

