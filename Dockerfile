FROM alpine:latest
LABEL maintainer "Alex Haydock <alex@alexhaydock.co.uk>"

# About the packages installed in this Docker image:
# (gcc needed to install our packages with pip later)
# (musl-dev and python2-dev provide headers needed to build the pip packages)

# Copy tweets_analyzer into container
COPY . /opt/app

# 1. Install packages
# 2. Link locale.h to xlocale.h (Fixes issue with xlocale.h missing during pip install)
# 3. Add Python dependencies
RUN apk --no-cache add \
      gcc \
      musl-dev \
      python2 \
      python2-dev \
      py2-pip \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip install -r /opt/app/requirements.txt

# (If no arguments are provided by the user then CMD applies and we will scan the @openrightsgroup user)
ENTRYPOINT ["python2","/opt/app/tweets_analyzer.py","--name"]
CMD ["openrightsgroup"]