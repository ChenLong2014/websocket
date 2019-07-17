websocket Config:

1.  defaultMaxTextMessageBufferSize : no mater what kind of way you handle the message, you cannot avoid the buffer。 
    this buffer is the socket NIO buffer，when a websocket connect，the buffer will be created。
    There are two ways to handle the message， partial or whole。
     
    
