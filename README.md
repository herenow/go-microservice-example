# Buscape Gateway

![](http://talks.golang.org/2014/go4gophers/gopherswrench.jpg)

# Gophers at work! Don't bother.

# Dependency managment (bundling/vendoring)

We manage dependencies by vendoring it, we use [Godep](https://github.com/tools/godep), and so should you :)

You can use `godep restore` to install the packages specified versions to your `$GOPATH`.
```bash
$ godep restore
```


# Deploying to heroku

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
