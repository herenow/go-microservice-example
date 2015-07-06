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

# Setup golang enviroment (temporary)
RUN mkdir -p /app/heroku
RUN mkdir -p /app/src
ENV GOROOT /app/heroku/goroot
ENV GOPATH /app/src/gopath
ENV GOBIN /app/src/gopath/bin
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Dependency manager
RUN go get github.com/tools/godep

# App setup
ENV HOME /app
ENV APP_ROOT /app/src/gopath/github.com/Codeminer/go-microservice-example
ENV PORT 3000
EXPOSE 3000

# Copy current source to container
ONBUILD COPY . $APP_ROOT

# Install dependencies
ONBUILD RUN cd $APP_ROOT && godep restore

# Install app
ONBUILD RUN cd $APP_ROOT & go get ./...

# Golang enviroment setup (persistent)
RUN mkdir -p /app/.profile.d
RUN echo "export GOROOT=\"/app/heroku/goroot\"" > /app/.profile.d/golang.sh
RUN echo "export GOPATH=\"/app/src/gopath\"" >> /app/.profile.d/golang.sh
RUN echo "export GOBIN=\"/app/src/gopath/bin\"" >> /app/.profile.d/golang.sh
RUN echo "export PATH=\"$GOROOT/bin:$GOPATH/bin:$PATH\"" >> /app/.profile.d/golang.sh

# Default into app folder
RUN echo "cd $APP_ROOT" >> /app/.profile.d/golang.sh
WORKDIR $APP_ROOT
