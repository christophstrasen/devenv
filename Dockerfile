FROM ubuntu:bionic

RUN apt-get update && \
	apt-get install sudo -y && \
	adduser --disabled-password --gecos '' christoph && \
	adduser christoph sudo && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists

# Required for `clear` command to work, etc.
ENV TERM screen-256color

COPY build.sh /tmp/build.sh

RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

# For some reason, this environment variable isn't set by docker.
ENV USER christoph

ENV HOME /home/christoph

WORKDIR /home/christoph

COPY ./inputrc "$HOME/.inputrc"

RUN sudo chown "$USER":"$USER" "$HOME/.inputrc"

#power-tmux

ENV XDG_CONFIG_HOME "$HOME/.config"

COPY ./powerline "$HOME/.config/powerline"

COPY ./.tmux.conf "$HOME/.tmux.conf"

COPY ./bashrc-additions.sh /tmp/bashrc-additions.sh

COPY ./.tmate.conf "$HOME/.tmate.conf"

COPY ./build-power-tmux.sh /tmp/build-power-tmux.sh

RUN bash /tmp/build-power-tmux.sh && \
	sudo rm /tmp/build-power-tmux.sh

# nvim

COPY ./build-nvim.sh /tmp/build-nvim.sh

COPY init.vim "$HOME/.config/nvim/init.vim"
COPY plugin.vim "$HOME/.config/nvim/plugin.vim"
COPY post-plugin.vim "$HOME/.config/nvim/post-plugin.vim"

COPY ./ycm-install /usr/local/bin/ycm-install

RUN /tmp/build-nvim.sh && \
	sudo rm /tmp/build-nvim.sh

# bashrc
COPY ./build-bashrc.sh /tmp/build-bashrc.sh
RUN /tmp/build-bashrc.sh && sudo rm /tmp/build-bashrc.sh

USER christoph

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

CMD ["bin/bash"]

#just a comment
