FROM heroku/cedar:14

# Setup user that will run our app
RUN useradd -d /app -m app
USER app
WORKDIR /app

# Install golang
ENV GOVERSION 1.4.2
RUN mkdir -p /app/heroku/goroot && mkdir -p /app/src/gopath
RUN curl https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
           | tar xvzf - -C /app/heroku/goroot --strip-components=1

# Setup golang enviroment (paths)
RUN mkdir -p /app/heroku
RUN mkdir -p /app/src
ENV GOROOT /app/heroku/goroot
ENV GOPATH /app/src/gopath
ENV GOBIN /app/src/gopath/bin
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# App setup
ENV HOME /app
ENV PORT 3000

# Copy current source to container
ONBUILD COPY . /app/src/gopath/github.com/root/go-microservice-example

# Install dependencies with godep
RUN go get github.com/tools/godep
ONBUILD RUN cd /app/src/gopath/github.com/root/go-microservice-example && godep restore

# Install app
ONBUILD RUN cd /app/src/gopath/github.com/root/go-microservice-example && go get ./...

WORKDIR /app/src/gopath/bin
ONBUILD EXPOSE 3000
