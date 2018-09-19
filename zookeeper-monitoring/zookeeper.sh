#!/bin/bash

HOST=127.0.0.1
PORT=2181
JMXPORT=1098
JMX_USER=your_user
JMX_PASS=your_pass

function zk_max_latency {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_max_latency |awk '{print $2}'
}

function zk_outstanding_requests {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_outstanding_requests |awk '{print $2}'
}

function zk_avg_latency {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_avg_latency |awk '{print $2}'
}

function zk_pending_syncs {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_pending_syncs |awk '{print $2}'
}

function zk_max_file_descriptor_count {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_max_file_descriptor_count |awk '{print $2}'
}

function zk_open_file_descriptor_count {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_open_file_descriptor_count |awk '{print $2}'
}

function alive {
PID=`/usr/bin/ps -ef|grep java|grep zookeeper|grep -v grep |awk '{print $2}' |head -n 1`

if [ -n "${PID}"  ]
then
	echo "${PID}"
else
	echo "0"
fi
}

function zk_server_ruok {
/usr/bin/echo ruok |nc ${HOST} ${PORT} |xargs
}

function zk_server_state {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_server_state |awk '{print $2}'
}

function zk_packets_received {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_packets_received |awk '{print $2}'
}

function zk_packets_sent {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_packets_sent |awk '{print $2}'
}

function zk_num_alive_connections {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_num_alive_connections |awk '{print $2}'
}

function zk_znode_count {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_znode_count |awk '{print $2}'
}

function zk_watch_count {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_watch_count |awk '{print $2}'
}

function zk_server_state {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_server_state  |awk '{print $2}'
}

function zk_approximate_data_size {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_approximate_data_size |awk '{print $2}'
}

function zk_ephemerals_count {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_ephemerals_count |awk '{print $2}'
}

function zk_followers {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_followers  |awk '{print $2}'
}

function zk_synced_followers {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_synced_followers |awk '{print $2}'
}

function zk_pending_syncs {
/usr/bin/echo mntr |nc ${HOST} ${PORT} |grep zk_pending_syncs  |awk '{print $2}'
}

function FreePhysicalMemorySize {
/usr/bin/java -jar /etc/zabbix/scripts/cmdline-jmxclient-0.10.3.jar $JMX_USER:$JMX_PASS ${HOST}:${JMXPORT} "java.lang:type=OperatingSystem" "FreePhysicalMemorySize" &> /tmp/jmx_mem
awk '{print $NF/8/1024/1024/1024}' /tmp/jmx_mem
rm -f /tmp/jmx_mem
}

function SystemCpuLoad {
/usr/bin/java -jar /etc/zabbix/scripts/cmdline-jmxclient-0.10.3.jar $JMX_USER:$JMX_PASS ${HOST}:${JMXPORT} "java.lang:type=OperatingSystem" "SystemCpuLoad" &> /tmp/jmx_system
awk '{print $NF}' /tmp/jmx_system
rm -f /tmp/jmx_system
}

function ProcessCpuLoad {
/usr/bin/java -jar /etc/zabbix/scripts/cmdline-jmxclient-0.10.3.jar $JMX_USER:$JMX_PASS ${HOST}:${JMXPORT} "java.lang:type=OperatingSystem" "ProcessCpuLoad" &> /tmp/jmx_process
awk '{print $NF}' /tmp/jmx_process
rm -f /tmp/jmx_process
}

${1}
