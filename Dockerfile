FROM alpine:3
LABEL maintainer "Alex Haydock <alex@alexhaydock.co.uk>"
LABEL name "tweets_analyzer"
LABEL version "1.0"

# About the packages installed in this Docker image:
# (gcc needed to install our packages with pip later)
# (musl-dev and python2-dev provide headers needed to build the pip packages)

# Copy tweets_analyzer into container
COPY . /opt/app

# 1. Install packages
# 2. Link locale.h to xlocale.h (Fixes issue with xlocale.h missing during pip install)
# 3. Add Python dependencies (pip for requirements.txt, and numpy directly because it takes forever to build otherwise)
RUN apk --no-cache add \
      py3-numpy \
      py3-pip \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && python3 -m pip install -r /opt/app/requirements.txt

# (If no arguments are provided by the user then CMD applies and we will scan the @openrightsgroup user)
ENTRYPOINT ["python3","/opt/app/tweets_analyzer.py","--name"]
CMD ["openrightsgroup"]
