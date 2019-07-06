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
      
