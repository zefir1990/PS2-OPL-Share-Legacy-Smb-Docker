FROM ubuntu:22.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends samba \
    && rm -rf /var/lib/apt/lists/*

COPY smb.conf /etc/samba/smb.conf

EXPOSE 139 445

CMD ["bash", "-c", "install -d /srv/samba/DVD /srv/samba/CD /srv/samba/CFG /srv/samba/ART /srv/samba/VMC /srv/samba/LNG /srv/samba/THM /srv/samba/CHT && exec smbd --foreground --no-process-group --debug-stdout --configfile=/etc/samba/smb.conf"]
