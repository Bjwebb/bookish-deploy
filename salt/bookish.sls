docker-installed:
    pkg.installed:
        - name: docker.io

docker-running:
    service.running:
        {% if grains['lsb_distrib_release']=='14.04' %}
        - name: docker.io
        {% else %}
        - name: docker
        {% endif %}

docker-py:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - name: docker_py>=0.5,<0.6

# https://github.com/saltstack/salt/issues/15803

bjwebb/bookish-demo:
    docker.pulled:
      - tag: latest
      - require:
        - pip: docker-py
      - force: True

docker_bookishdemo_stop_if_old:
  cmd.run:
    - name: docker stop bookishdemo
{% raw %}
    - unless: docker inspect --format "{{ .Image }}" bookishdemo | grep $(docker images | grep "bjwebb/bookish-demo" | awk '{ print $3 }')
{% endraw %}
    - require:
      - docker: bjwebb/bookish-demo

docker_bookishdemo_remove_if_old:
  cmd.run:
    - name: docker rm bookishdemo
{% raw %}
    - unless: docker inspect --format "{{ .Image }}" bookishdemo | grep $(docker images | grep "bjwebb/bookish-demo" | awk '{ print $3 }')
{% endraw %}
    - require:
      - cmd: docker_bookishdemo_stop_if_old

bookishdemo-container:
  docker.installed:
    - name: bookishdemo
    - image: bjwebb/bookish-demo:latest
    - environment:
      - SENTRY_DSN: {{ pillar.get('sentry_dsn') }}
    - require:
      - cmd: docker_bookishdemo_remove_if_old

bookishdemo-service:
  docker.running:
    - container: bookishdemo
    - port_bindings:
        '8000/tcp':
            HostIp: ''
            HostPort: '80'
    - require:
      - docker: bookishdemo-container

