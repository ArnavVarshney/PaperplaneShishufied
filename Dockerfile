# We're using Alpine Edge
FROM alpine:edge

#
# We have to uncomment Community repo for some packages
#
RUN sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' -i /etc/apk/repositories

#
# Installing Packages
#
RUN apk add --no-cache --update \
    bash \
    build-base \
    bzip2-dev \
    curl \
    figlet \
    gcc \
    g++ \
    git \
    sudo \
    aria2 \
    util-linux \
    chromium \
    chromium-chromedriver \
    jpeg-dev \
    libffi-dev \
    libpq \
    libwebp-dev \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    musl \
    neofetch \
    openssl-dev \
    postgresql \
    postgresql-client \
    postgresql-dev \
    openssl \
    pv \
    jq \
    wget \
    python3 \
    python3-dev \
    readline-dev \
    sqlite \
    ffmpeg \
    sqlite-dev \
    sudo \
    zlib-dev


RUN python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && rm -r /usr/lib/python*/ensurepip && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

#
# Clone repo and prepare working directory
#
RUN git clone https://github.com/ArnavVarshney/PaperplaneShishufied /root/userbot
RUN mkdir /root/userbot/bin
WORKDIR /root/userbot/

#
# Copies session and config (if it exists)
#
COPY config.env ./userbot.session* ./config.env* /root/userbot/

#
# Clone helper scripts
#
RUN curl -s https://raw.githubusercontent.com/yshalsager/megadown/master/megadown -o /root/userbot/bin/megadown && sudo chmod a+x /root/userbot/bin/megadown
RUN curl -s https://raw.githubusercontent.com/yshalsager/cmrudl.py/master/cmrudl.py -o /root/userbot/bin/cmrudl && sudo chmod a+x /root/userbot/bin/cmrudl
ENV PATH="/root/userbot/bin:$PATH"

#
# Install requirements
#
# wheel had to be installed separetely to prevent errors during deployment
RUN pip3 install wheel
RUN pip install wheel
RUN pip3 install -r requirements.txt
CMD ["python3","-m","userbot"]
