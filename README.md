### Docker file for Faveo Helpdesk

###  Extra ###
So, the image built, the image is running, try to access it with an ip address
I did docker inspect (image-name) and it gave me an ip.
Don't think the ports are exposed yet.

To be continued.


With this Docker file you can build a Docker image for Faveo Helpdesk

### How to use

Clone the repository. 

Make sure you have docker-compose installed on your server. 

Run the following command to start Faveo and mySQL image:

`docker-compose up -d`

Open you ip address for fininshing Faveo installation.

When asked about database config. Use the same credentials as in docker-compose.yml:

       MYSQL_ROOT_PASSWORD: faveo
       MYSQL_DATABASE: faveo
       MYSQL_USER: faveo
       MYSQL_PASSWORD: faveo

You can change the environment variables for database configuration.

### To change the nginx config image for your server edit default.conf

After changing nginx config rebuild the image.

`docker build -it "repo_name" .`

Now start the server using your own local image by changing the docker-compose file with your repo name as image under faveo:

       faveo:
          image: repo_name

### Contributing

Create your own fork of Faveo master repositoray and use [git-flow](https://github.com/nvie/gitflow)  to create a new feature. Once the feature is published in your fork, send a pull request to begin the conversation of integrating your new feature into Faveo.

### Help

Visit the [issue](https://github.com/ladybirdweb/faveo-docker/issues) page. And if you'd like professional help commercial support is available, email us through the [Contact form](http://www.faveohelpdesk.com/contact-us/).

### Documentation
https://docs.google.com/document/d/1l2QyGGtxSm1ta-2qCkw7A3G74UqUKSPi8fgBCblRbqA


### Reference
- https://hub.docker.com/r/ladybirdweb/faveo-docker
- https://github.com/ladybirdweb/faveo-server-images
