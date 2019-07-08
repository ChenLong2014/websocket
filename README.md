# websocket
summarize of websocket

    Websockt is a easy way to use socket with rest API, it is a good way that using two kind of technology in one environment -- TOMCAT
    
    Following is what kind of problem we meet~~~
    
    1st.
      GC problem. 
      MessageHandler-partial/-whole, different way you choose, will have GC problem when concurrent comes.
      When you use MessageHandler-Whole to solve Big Binary or Text, it will comes GC.
      
      SO we Adjust our GC.
      JAVA_OPTS="$JAVA_OPTS -Xms6g -Xmx6g -Xmn4g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -XX:SurvivorRatio=2 "
      JAVA_OPTS="$JAVA_OPTS -server -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:ParallelGCThreads=16 -XX:+UseAdaptiveSizePolicy "
      JAVA_OPTS="$JAVA_OPTS -Xloggc:/tmp/gclog_`hostname`_`date +"%G%m%d_%H%M%S"`.txt -XX:+PrintGCDetails 
      
  
     2nd.
       Use MessageHandler.partial to Solve Big Binary or Text. There is few Reference. I will show how to use it.
       
     3rd.
        Since our service has reconnect, so we reconnet when the session closed, to improve Customer Experience.
        
     WHY the tomcat Reference is so few to find. Because it is really easy to use.
 
     4th.   GC Server Backend（502 response） Accident Review
        整体事件回顾，当用户量激增的时候，相关服务页面无法打开，页面显示，Nginx 后端报错 502，需要重新启动服务端。
        问题处理：
        1）查看Server 的日志
            发现Server 端在每次502 的时候，都会发现后端无法连接，Connot Connect peer to peer等等，session 的问题。
        2）查看Server 的GC
            发现Server 在出现502 左右的时候，都会发生非常多次的FULL GC，导致其他业务无法连接
        3）查看Server 的Heap
            发现Server 在出现502 的时候，整个新生代，老年代都是满的状态，内存无法回收。
     
     5th. Deal with problem
         查看整体的jstat，jmap，jstack，netstat
         当CPU 不高时，可以排除由jstack 的原因导致的问题。jstack 主要是反映由于线程过多或者线程频繁处理任务导致CPU 高居不下。
         当GC 过多的时候，很有可能是
         1）JVM 的配置有问题
         2）代码中内存的使用有问题，导致无法及时回收
       
     6.th Detail of Process
         Watching GC，modifing JVM configuration
         Jstack Tomcat，whether the thread is no suspending or blocking. If CPU of Tomcat is not high，we don`t need to analyze stack problem。
         Dump the Mem of Tomcat，analyze the memory。It must be very complex，every object maybe the cause of issue。 eg. ]B is the system object，but in this case，we use tomcat websocket，the most data is Byte。 SO ]B is too much bigger。
         
      
         
