# https://github.com/pschiffe/pcs, with modifications for vagrant to work
FROM fedora:41

RUN echo 'root:root' | chpasswd

RUN dnf install -y openssh-server openssh-clients python3 python3-pip wget ansible scp

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN mkdir -p /root/.ssh
COPY id_rsa.pub /root/.ssh/authorized_keys

RUN echo 'install_weak_deps=False' >> /etc/dnf/dnf.conf \
  && echo 'assumeyes=True' >> /etc/dnf/dnf.conf \
  && sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-cisco-openh264.repo \
  && dnf --refresh upgrade \
  && dnf install \
    pcs \
    which \
    cracklib-dicts \
  && dnf clean all

RUN mkdir -p /etc/systemd/system-preset \
  && echo 'enable pcsd.service' > /etc/systemd/system-preset/00-pcsd.preset \
  && systemctl enable pcsd

ENV DOCKER_HOST="unix:///var/docker.sock"

EXPOSE 22

CMD [ "/usr/lib/systemd/systemd", "--system" ]
