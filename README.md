# docker-jbossweb

# Build
## Java 1.7.0_79
```
cd java7
docker build -t jbossweb:1.7.0_79 .
```
## Java 1.8
```
cd java8
docker build -t jbossweb:1.8 .
```
# Start
```
docker run -d -p 8080:8080 -p 8009:8009 --name ap01 -e JAVA_OPTS="-server -Xms256m -Xmx2048m -Dfile.encoding=UTF8 -Duser.timezone=Taiwan/Taipei -XX:-UseSplitVerifier" -v /opt/war:/opt/war jbossweb:1.8
```