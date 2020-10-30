FROM geerlingguy/docker-ubuntu2004-ansible
LABEL description="appserver"

# Install Flask app dependencies.
RUN apt-get update
RUN apt-get install -y libmysqlclient-dev build-essential \
  python3-dev python3-pip 
RUN pip3 install flask mysqlclient flask-mysqldb

# Create directory and move files over for Flask
RUN mkdir -m 755 /opt/www

COPY app.py /opt/www/app.py
COPY templates /opt/www/templates
COPY static /opt/www/static

# Ensure container listens on port 80
EXPOSE 80