FROM fedora:27
WORKDIR /workdir

EXPOSE 8888
EXPOSE 5900
EXPOSE 2121

RUN groupadd -g 9999 appuser
RUN useradd -r -u 9999 -g appuser appuser

RUN dnf install -y tigervnc-server-minimal python3-websockify lxde-common fluxbox gcc-c++ avr-gcc-c++ wget java-1.8.0-openjdk java-1.8.0-openjdk-devel git codeblocks lxterminal leafpad lxappearance adwaita-gtk2-theme adwaita-icon-theme open-sans-fonts xorg-x11-fonts-* nano qt5-devel adwaita-qt5 qt5-qtstyleplugins qt-creator make cmake
RUN dnf install -y ftp
RUN dnf install -y python2-numpy python3-numpy python2-matplotlib python3-matplotlib
RUN pip install keras
RUN pip3 install keras

RUN dnf install -y node npm
RUN npm install -g ftpd

RUN touch /workdir/vncpasswd
RUN chmod a+rw /workdir/vncpasswd
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

RUN chown appuser /home/appuser/.config
RUN chmod 777 /home/appuser/.config

RUN rm /usr/bin/qmake-qt5.sh

ENV GEOMETRY 1536x864
ENV VNCPASSWD DWIF6rahF0w=
ENV FTP_USERNAME ftp
ENV FTP_PASSWORD bgsmrdi

USER 9999

ENTRYPOINT ["bash", "init.sh"]
