FROM redhat/ubi8:latest

ENV TM_LICHOST=172.0.0.1 \
    TM_LICPORT=57777 \
    TM_LICPASS=docker \
    TM_CONTAINER_EXT=false

LABEL name="Solution-Soft/Time Machine Sidecar for Kubernetes" \
      vendor="SolutionSoft Systems, Inc" \
      version="18.03" \
      release="67" \
      summary="Time Machine Sidecar for Kubernetes Image" \
      description="Time Machine creates virtual clocks for time shift testing of Applications" \
      url="https://solution-soft.com" \
      maintainer="kzhao@solution-soft.com"

COPY help.1 /
COPY licenses /licenses/

COPY dist /dist
COPY entrypoint.sh /

ARG TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

RUN chown root:root /tini \
&&  chmod +x /tini \
&&  chown -R root:root /dist \
&&  chmod ug+s /dist/bin/tmdeploy \
&&  chown root:root /entrypoint.sh \
&&  chmod 0555 /entrypoint.sh \
&&  useradd -g 0 default \
&&  mkdir -p /etc/ssstm /opt/ssstm \
&&  chown default:0 /etc/ssstm /opt/ssstm \
&&  chmod ug+w /etc/ssstm /opt/ssstm

RUN cp /dist/sbin/tmagent /usr/sbin/tmagent \
&&  chmod 0555 /usr/sbin/tmagent \
&&  chown root:root /usr/sbin/tmagent

EXPOSE 5777 7800

USER default

STOPSIGNAL SIGTERM

HEALTHCHECK \
    --start-period=10s \
    --interval=5m \
    --timeout=5s \
    CMD curl -f http://127.0.0.1:7800/tmapp/getstatus || exit 1

ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]
