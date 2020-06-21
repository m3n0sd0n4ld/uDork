FROM python:rc-alpine3.12
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
ENV FACEBOOK_COOKIE 'changeme'
ENTRYPOINT ["/usr/local/bin/python3", "./uDork.py"]
CMD ["-h"]
