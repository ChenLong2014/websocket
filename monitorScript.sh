#Java堆信息打印,仅dump当前存活的对象

/opt/webserver/programs/jdk/bin/jmap -dump:live,format=b,file=/srv/smartcare/dsi/dump_`hostname`_`date +"%G%m%d_%H%M%S"`.hprof $(ps -ef|grep -v grep|grep dsi.jar|awk '{print $2}')

#打印出占用堆最大的前20类型信息
/opt/webserver/programs/jdk/bin/jmap -histo $(ps -ef|grep -v grep|grep dsi.jar|awk '{print $2}') |head -n 50 >> /tmp/dump_his_20_`hostname`_`date +"%G%m%d_%H%M%S"`.txt

#打印某个进程中线程资源占用情况
top -H -p $(ps -ef|grep -v grep|grep dsi.jar|awk '{print $2}') >> /tmp/topH_`hostname`_`date +"%G%m%d_%H%M%S"`.txt

#打印线程栈
/opt/webserver/programs/jdk/bin/jstack $(ps -ef|grep -v grep|grep dsi.jar|awk '{print $2}') >> /tmp/stack_`hostname`_`date +"%G%m%d_%H%M%S"`.tdump 

#打印gc的概要信息
/opt/webserver/programs/jdk/bin/jstat -gcutil $(ps -ef|grep -v grep|grep dsi.jar|awk '{print $2}') 2s >> /tmp/gcutil_`hostname`_`date +"%G%m%d_%H%M%S"`.txt 

#分析java 的dump文件
/opt/webserver/programs/jdk/bin/jhat -stack true -refs true /tmp/dump_193-195-18-118_20111231_094544.hprof 

/opt/UQuery/jdk/bin/jmap -heap $(ps -ef|grep -v grep|grep java|awk '{print $2}')

/opt/UQuery/jdk/bin/jmap -dump:format=b,file=dump-3.file 【PID】

/opt/UQuery/jdk/bin/jhat -J-Xmx1024m /tmp/dump-3.file

netstat -nat | grep 【PID】

查询server 网口流量
ifstat
