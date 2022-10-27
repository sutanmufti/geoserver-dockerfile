# Geoserver docker

dockerfile recipe to install geoserver on ubuntu 20.04.

I don't recommend this for production environment. This repo is made based on private needs. For production env, please look at the following repo:
[Geoserver by Kartoza](https://github.com/kartoza/docker-geoserver/)

however, any PR is welcome.

# Building the image

(optional) Before building, adjust ```tomcat-users.xml```, change the username and password.

``` 
vi tomcat-users.xml
# edit the tomcat username and password
```

Build the image with following command

```bash
docker build --name geoserver:latest .
```

To run the image

```bash
docker run -d --name geoserver -p 8080:8080 geoserver
```

then open this link to access

```
https://localhost:8080/geoserver
```


## data persistence

when the container is destroyed (```docker remove <container>```), geoserver data is also destroyed. This can be overriden by persisting data by mounting with ```-v``` arg in Docker in the ```docker run```.

1. ensure you have file sharing to your local data dir. open docker desktop app -> settings -> resources -> file sharing. Add the dir path you want to connect to the container. This is also called mounting.
2. Run docker run command with ```-v``` flag. For example.

```bash
docker run --name geoserver -d -p 8081:8080 -v C:/Users/SutanMufti/filesharedocker/data_dir:/usr/share/geoserver/data_dir geoserver   
```
explanation:
1. the ```-p 8081:8080``` means that everytime we visit ```localhost:8081``` in our browser, it will forward to the docker container's port ```8080``` which is the default set up of tomcat installed in the container.
2. let's look at the ```-v``` flag. the first bit is my local file, the second bit is the container file. Here's how to see it: Every time geoserver populate the container's ```/usr/share/geoserver/datadir```, geoserver will also edit ```c:/.../data_dir``` which is located in my pc. My directory is connected to the container.
3. therefore if the container is destroyed, the container's ```/.../data_dir``` is preserved in my local pc.


## vulnerabilities

there are some vulnerabilities:

- ```tomcat-users.xml```  is still in default. You might want to change this.
- any others?

maintainer: sutan mufti (@urban_planning)
