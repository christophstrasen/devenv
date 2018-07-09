FROM ubuntu:bionic
ARG UID=1000
ARG GID=1000
ARG UNAME=christoph

RUN apt-get update && \
	apt-get install sudo netcat -y && \
	groupadd -g $GID $UNAME && \
	useradd -m -u $UID -g $GID -s /bin/bash $UNAME  && \
	usermod -aG sudo $UNAME && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists

# Required for `clear` command to work, etc.
ENV TERM screen-256color

ENV USER $UNAME

COPY build.sh /tmp/build.sh

RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

ENV HOME /home/$UNAME

WORKDIR /home/$UNAME

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
RUN npm install -g eslint

# docker dev
RUN wget -q https://storage.googleapis.com/golang/getgo/installer_linux && chmod +x installer_linux && ./installer_linux && source ~/.bash_profile
RUN nvim +GoInstallBinaries

USER $UNAME

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

CMD ["/bin/bash"]

#just a comment
