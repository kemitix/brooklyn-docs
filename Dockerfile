FROM ubuntu

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q && \
    apt-get install -qy curl python ca-certificates gnupg2 build-essential --no-install-recommends && \
    apt-get clean

# Install rvm
RUN gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable && \
    /bin/bash -l -c ". /etc/profile.d/rvm.sh"

# Use the following command to find available ruby versions to install - update Gemfile to selected version
# RUN /bin/bash -l -c "rvm list known"
RUN /bin/bash -l -c "rvm install ruby-2.4.10"

WORKDIR /usr/workspace

COPY Gemfile .
RUN /bin/bash -l -c "bundle install"

ENTRYPOINT ["/bin/bash", "-l", "-c"]