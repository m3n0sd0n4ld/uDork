FROM python:rc-alpine3.12
WORKDIR /app
ADD . /app
RUN pip install -r requiremnents.txt
ENV FACEBOOK_COOKIE 'changeme'
ENTRYPOINT ['python3', './uDork.py']
CMD '--help'
