# Buscape Gateway

![](http://talks.golang.org/2014/go4gophers/gopherswrench.jpg)

# Gophers at work! Don't bother.

### Dependency managment (bundling/vendoring)

We manage dependencies by vendoring it, we use [Godep](https://github.com/tools/godep), and so should you :)

You can use `godep restore` to install the packages specified versions to your `$GOPATH`.
```bash
$ godep restore
```


### Development enviroment

I think most people are using [docker](https://www.docker.com/) by now, so do we. We setup out container using the heroku [cedar-14 docker image](https://registry.hub.docker.com/u/heroku/cedar/).

#### Dependencies
You need to have on your system, the [heroku cli](https://github.com/heroku/heroku-cli), the [heroku-docker plugin](https://github.com/heroku/heroku-docker/), and [docker](http://docs.docker.com/) (my version is `Docker version 1.7.0, build 0baf609
`).

#### Install the heroku-docker plugin
Once you have `heroku` and `docker` installed, run this to install the heroku-docker plugin.

```bash
$ heroku plugins:install heroku-docker
```

#### Run the app

```bash
$ heroku docker:start
```

You should see something like this, after docker is setup:
![](https://www.dropbox.com/s/61cmejcoaedyk22/Screenshot%202015-07-05%2018.46.36.png?dl=0&raw=1)

#### Start the app

```bash
$ heroku docker:start
```


### Deploying to heroku

First, create a heroku app using the Go buildpack (provided by heroku).

```bash
$ heroku create -b https://github.com/heroku/heroku-buildpack-go.git
```

Here's an example Procfile (for this project).

```lang
web: go-service-example -port=$PORT
worker: dispatcher-worker
```

Now deploy :)

```bash
$ git push heroku master
```

#### Deploying from docker image

Note that you can deploy to any docker compatible infrastructure, in heroku you can use the following commands to do so.

* Note: https://blog.heroku.com/archives/2015/5/5/introducing_heroku_docker_release_build_deploy_heroku_apps_with_docker
  * This is still in beta (Golang is not officially supported)
  * I'm still figuring out some nuances about this approach.
  * Such as, the slug size is too big, and deployment is considerably slower.

```bash
$ heroku docker:release
```
