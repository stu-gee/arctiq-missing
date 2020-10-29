FROM geerlingguy/docker-ubuntu2004-ansible
LABEL description="Test Flask app"

# Install Flask app dependencies.
RUN apt-get update
RUN apt-get install -y libmysqlclient-dev build-essential \
  python3-dev python3-pip
RUN pip3 install flask flask-mysqldb mysqlclient

# Install playbook and run it.
COPY playbook.yml /etc/ansible/playbook.yml
COPY app.py.j2 /etc/ansible/app.py.j2
COPY templates /etc/ansible/templates
COPY static /etc/ansible/static
RUN mkdir -m 755 /opt/www
RUN ansible-playbook /etc/ansible/playbook.yml --connection=local

EXPOSE 80