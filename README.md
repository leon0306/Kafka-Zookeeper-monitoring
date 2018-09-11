# Kafka-Zookeeper-monitoring-by-zabbix

### First you have to install zabbix-java-gataway
    yum install -y zabbix-java-gataway
### Configuring zabbix-java-gataway
    mcedit /etc/zabbix/zabbix_java_gateway.conf
+ Uncoment and set **START_POLLERS=10**
### Configuring zabbix-server
    mcedit /etc/zabbix/zabbix_server.conf
+ Uncoment and set to **StartJavaPollers=5**
+ Change IP for **JavaGateway=IP_address_java_gateway**
### Restart zabbix-server
    /etc/init.d/zabbix-java-gataway restart
### Add to autorun zabbix-java-gataway
     chkconfig --level 345 zabbix-java-gataway on
### Start zabbix-java-gataway
    /etc/init.d/zabbix-java-gataway start
# Configuring monitoring broker
    cp jmx_discovery /etc/zabbix/externalscripts  
    cp JMXDiscovery-0.0.1.jar /etc/zabbix/externalscripts  ## On zabbix server not client.
    chmod a+x jmx_discovery
+ Download template [zbx_kafka_templates.xml] and upload to zabbix

# Configuring monitoring consumer
     cp kafka_consumers.sh /etc/zabbix/
     chmod a+x kafka_consumers.sh
     cp userparameter_kafkaconsumer.conf /etc/zabbix/zabbix_agentd.d
+ Download template [zbx_kafka_consumer_templates.xml],[zbx_valuemaps_kafkaconsumers.xml] and upload to zabbix
### Install burrow
     cd kafka-monitoring/kafkaconsumers
     cp -r burrow /opt/
     cp burrow.service /usr/lib/systemd/system/burrow.service
     systemctl enable burrow && systemctl start burrow
+ You should change config file in /opt/burrow/config/burrow.toml
### Install jq 
     cd /usr/bin
     wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64  ## or using EPEL-7 repo to install jq
     mv jq-linux64 jq
     chmod +x jq
# Zookeeper-monitoring
    cd Kafka-Zookeeper-monitoring/zookeeper-monitoring
    cp zookeeper.sh /etc/zabbix/scripts  ## You should edit env in scripts on you own
    chmod a+x zookeeper.sh
    cp userparameter_zookeeper.conf /etc/zabbix/zabbix_agentd.d
+ Download template [zbx_zookeeper_templates.xml] and upload to zabbix
