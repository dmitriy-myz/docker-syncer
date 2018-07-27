FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y inotify-tools rsync && \
    apt-get install -y curl cmake build-essential liblua5.2-dev liblua5.2 lua5.2 && \
    apt-get clean && \
    rm /var/lib/apt/lists/*.lz4 && \
    cd /tmp && \
    curl -L https://github.com/axkibe/lsyncd/archive/release-2.2.3.tar.gz > lsyncd.tar.gz && \
    tar -xzvf lsyncd.tar.gz && \
    rm lsyncd.tar.gz && \
    cd lsyncd-release-2.2.3 && \
    cmake . && \
    make && \
    make install && \
    cd /tmp && \
    rm -r lsyncd-release-2.2.3 && \
    apt-get remove -y curl cmake build-essential liblua5.2-dev lua5.2 && \
    apt-get autoremove -y && \
    mkdir /opt/fs-syncer
ADD ./* /opt/fs-syncer/
