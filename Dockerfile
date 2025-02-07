# Grab the latest alpine image
FROM alpine:latest

# Install python, pip, and bash
RUN apk add --no-cache --update python3 py3-pip bash

# Create a virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Copy requirements and install dependencies inside the virtual environment
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app. CMD is required to run on Heroku
CMD gunicorn --bind 0.0.0.0:$PORT wsgi


