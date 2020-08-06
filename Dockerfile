FROM jlesage/baseimage-gui:alpine-3.12

#Install borgbackup
RUN add-pkg borgbackup py3-psutil py3-qt5 py3-pynacl py3-cryptography py3-bcrypt

RUN \
	add-pkg --virtual build-base py3-pip && \
	pip3 install --upgrade pip && pip3 install vorta && \
	del-pkg build-base

COPY startapp.sh /startapp.sh

ENV APP_NAME="Vorta"
