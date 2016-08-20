FROM phusion/passenger-ruby23

# Set correct environment variables.
ENV HOME /root
ENV RACK_ENV production

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Enable nginx and Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Create virtual host
ADD docker/vhost.conf /etc/nginx/sites-enabled/app.conf

# Prepare folders
RUN mkdir /home/app/webapp

# Run Bundle in a cache efficient way
WORKDIR /tmp
COPY application/Gemfile /tmp/
COPY application/Gemfile.lock /tmp/
RUN bundle install

# Add our app
COPY application /home/app/webapp
RUN chown -R app:app /home/app

# Clean up when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
