# nesenv
Docker build environment for NES/cc65 projects:
- cc65
- nestools
- wine64
- FamiTracker

# Cloning
This project uses submodules. Be sure to clone recursively:

```
git clone --recursive https://github.com/r-gerard/nesenv.git
```

# Building
Self explanatory:

```
docker build -t rgerard/nesenv:latest .
```

# Releasing
Tag the build with the shortened commit author date (YYYYmmdd) and the abbreviated commit hash:

```
docker tag rgerard/nesenv:latest "rgerard/nesenv:$(git log --pretty=format:'%ad' --date=short -n 1 | tr -d '-')"
docker tag rgerard/nesenv:latest "rgerard/nesenv:$(git log --pretty=format:'%h' -n 1)"
docker push rgerard/nesenv
```

# Usage
This image is meant to be used as an interactive shell with an attached volume containing your project files:

```
docker run --rm -it -v "$(pwd):/home/root/work" rgerard/nesenv:latest
```

...Then simply run your build commands from the running container, e.g. `make clean all`.
