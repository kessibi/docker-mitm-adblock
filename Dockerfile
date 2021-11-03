FROM python:alpine3.14

# necessary for building mitm-adblock
RUN apk add git gcc g++ musl-dev libffi-dev re2-dev openssl-dev wget

WORKDIR /tmp
RUN wget https://snapshots.mitmproxy.org/7.0.4/mitmproxy-7.0.4-linux.tar.gz
RUN tar xzvf mitm*.tar.gz

WORKDIR /home/mitm
RUN git clone https://github.com/epitron/mitm-adblock.git

RUN mv /tmp/mitmdump /usr/bin

WORKDIR /home/mitm/mitm-adblock

RUN /usr/local/bin/python -m pip install --upgrade pip

RUN pip install 'Cython>=0.29.19,<1.0'
RUN pip install -r requirements.txt

RUN sh ./update-blocklists

# cleaning
RUN rm -rf /tmp/mitm*

# once built, the packages are useless
RUN apk del git gcc musl-dev libffi-dev openssl-dev wget
# g++ and re2-dev are needed for runtime

RUN cat go | sed 's/100k/100k --set block_global=false/g' > go2
RUN chmod +x go2 && mv go2 go

EXPOSE 8118

CMD ["sh", "go", "-d"]

