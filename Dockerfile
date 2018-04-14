FROM fedora:27
WORKDIR /workdir

EXPOSE 8888
EXPOSE 5900
EXPOSE 2121

RUN groupadd -g 9999 appuser
RUN useradd -r -u 9999 -g appuser appuser

RUN dnf install -y tigervnc-server-minimal 
RUN dnf install -y python3-websockify
RUN dnf install -y lxde-common fluxbox
RUN dnf install -y gcc-c++ avr-gcc-c++
RUN dnf install -y wget java-1.8.0-openjdk java-1.8.0-openjdk-devel git codeblocks
RUN dnf install -y lxterminal leafpad
RUN dnf install -y lxappearance adwaita-gtk2-theme adwaita-icon-theme open-sans-fonts xorg-x11-fonts-*
RUN dnf install -y python3-twisted ftp

ADD vncpasswd /workdir
RUN chmod a+r /workdir/vncpasswd
ADD init.sh /workdir
ADD ftppasswd /workdir
RUN chmod a+r /workdir/ftppasswd

RUN mkdir -p /home/appuser
RUN chown appuser /home/appuser
RUN chmod 777 /home/appuser
RUN mkdir /home/appuser/Documents
RUN chown appuser /home/appuser/Documents
RUN chmod 777 /home/appuser/Documents

RUN mkdir -p /home/appuser/.config/lxsession/LXDE
RUN mkdir -p /home/appuser/.config/gtk-3.0
ADD desktop.conf /home/appuser/.config/lxsession/LXDE/desktop.conf
ADD .gtkrc-2.0 /home/appuser/.gtkrc-2.0
ADD gtk3-settings.ini /home/appuser/.config/gtk-3.0/settings.ini

USER 9999

ENTRYPOINT ["bash", "init.sh"]
