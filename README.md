# Buscape Gateway

![](http://talks.golang.org/2014/go4gophers/gopherswrench.jpg)

# Gophers at work! Don't bother.


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
