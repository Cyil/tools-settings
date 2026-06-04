#jdk1.8
export JAVA_HOME=/opt/jdk8
export PATH=${PATH}:${JAVA_HOME}/bin
export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar

#jdk17
#export JAVA_HOME=/opt/jdk17
#export PATH=${PATH}:${JAVA_HOME}/bin
#export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar

#jdk21
#export JAVA_HOME=/opt/jdk21
#export PATH=${PATH}:${JAVA_HOME}/bin
#export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar

# maven
export MAVEN_HOME=/opt/apache/apache-maven-3.9.9
export PATH=$PATH:$MAVEN_HOME/bin

#Golang
export GOROOT=/opt/go
