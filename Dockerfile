FROM python:alpine3.14

WORKDIR /home/mitm

# necessary for building mitm-adblock
RUN apk add git gcc g++ musl-dev libffi-dev re2-dev openssl-dev wget

RUN wget https://snapshots.mitmproxy.org/7.0.4/mitmproxy-7.0.4-linux.tar.gz

RUN tar xzvf mitm*.tar.gz

RUN git clone https://github.com/epitron/mitm-adblock.git

RUN mv mitmdump mitmproxy mitmweb /usr/bin

WORKDIR /home/mitm/mitm-adblock

RUN /usr/local/bin/python -m pip install --upgrade pip

RUN pip install 'Cython>=0.29.19,<1.0'
RUN pip install -r requirements.txt

RUN sh ./update-blocklists

# once built, the packages are useless
RUN apk del git gcc g++ musl-dev libffi-dev re2-dev openssl-dev wget



