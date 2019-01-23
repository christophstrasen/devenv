FROM ubuntu:bionic
ARG UID=1000
ARG GID=1000
ARG UNAME=defaultuser

RUN apt-get update && \
	apt-get install sudo netcat wget -y && \
	groupadd -g $GID $UNAME && \
	useradd -m -u $UID -g $GID -s /bin/bash $UNAME  && \
	usermod -aG sudo $UNAME && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists

# Required for `clear` command to work, etc.
ENV TERM xterm-256color

ENV USER $UNAME

COPY build.sh /tmp/build.sh

RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

ENV HOME /home/$UNAME

WORKDIR /home/$UNAME

RUN sudo apt-get update && sudo apt-get install vim -y

COPY ./inputrc "$HOME/.inputrc"

RUN sudo chown "$USER":"$USER" "$HOME/.inputrc"

#power-tmux

#ENV XDG_CONFIG_HOME "$HOME/.config"

COPY ./powerline "$HOME/.config/powerline"

COPY ./.tmux.conf "$HOME/.tmux.conf"

COPY ./.tmate.conf "$HOME/.tmate.conf"

COPY ./build-power-tmux.sh /tmp/build-power-tmux.sh

RUN bash /tmp/build-power-tmux.sh && \
	sudo rm /tmp/build-power-tmux.sh

COPY ./yank.sh "$HOME/yank.sh"

# nvim

COPY ./build-nvim.sh /tmp/build-nvim.sh

COPY init.vim "$HOME/.config/nvim/init.vim"
COPY plugin.vim "$HOME/.config/nvim/plugin.vim"
COPY post-plugin.vim "$HOME/.config/nvim/post-plugin.vim"

COPY ./ycm-install /usr/local/bin/ycm-install

RUN /tmp/build-nvim.sh && \
	sudo rm /tmp/build-nvim.sh

# bashrc

COPY ./bashrc-additions.sh /tmp/bashrc-additions.sh
COPY ./build-bashrc.sh /tmp/build-bashrc.sh
RUN /tmp/build-bashrc.sh && sudo rm /tmp/build-bashrc.sh
RUN npm install -g eslint
USER $UNAME

RUN sudo npm install -g eslint

RUN apt-get update
RUN apt-get install sudo -y python3-dev python-dev python3-dbus python-dbus
RUN pip install jrnl[encrypted] PyCrypto secretstorage keyrings.alt

# golang
RUN wget -q https://storage.googleapis.com/golang/getgo/installer_linux
RUN chmod +x installer_linux
SHELL ["/bin/bash", "-c"]
ENV SHELL bash
RUN ./installer_linux 
RUN source ~/.bash_profile
RUN nvim +GoInstallBinaries +qall

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

CMD ["/bin/bash"]

#just a comment
