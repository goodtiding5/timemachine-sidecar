FROM registry.access.redhat.com/ubi7/ubi:latest

ENV TM_LICHOST=172.0.0.1 \
    TM_LICPORT=57777 \
    TM_LICPASS=docker

LABEL name="Solution-Soft/Time Machine Sidecar for Kubernetes" \
      vendor="SolutionSoft Systems, Inc" \
      version="18.03" \
      release="58" \
      summary="Time Machine Sidecar for Kubernetes Image" \
      description="Time Machine creates virtual clocks for time shift testing of Applications" \
      url="https://solution-soft.com" \
      maintainer="kzhao@solution-soft.com"

COPY help.1 /
COPY licenses /licenses/

COPY dist /dist
COPY entrypoint.sh /

RUN chown -R root:root /dist \
&&  chmod u+s /dist/bin/tmdeploy \
&&  chown root:root /entrypoint.sh \
&&  chmod 0555 /entrypoint.sh \
&&  useradd -g 0 default \
&&  mkdir -p /etc/ssstm /opt/ssstm \
&&  chown default:0 /etc/ssstm /opt/ssstm \
&&  chmod ug+w /etc/ssstm /opt/ssstm

EXPOSE 5777 7800

USER default

STOPSIGNAL SIGTERM

HEALTHCHECK \
    --start-period=5m \
    --interval=5m \ 
    CMD ping -c 1 localhost || exit 1

ENTRYPOINT ["/entrypoint.sh"]
