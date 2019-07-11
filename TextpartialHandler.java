public class TextPartialHandler implements MessageHandler.Partial<String>{

  Session session;
  String id;
  StringBuilder sb;

  public BackendTextPartialHandler(Session session) {
	  this.session = session;
	  this.id = UUID.randomUUID().toString();
	  sb = new StringBuilder();
	}
  
  @Override
  public void onMessage(String messagePart, boolean last) {
     sb.append(messagePart);
     if (last) {
	frontend.getBasicRemote().sendText(sb.toString());
	sb = new StringBuilder();
     }
  }
}

/**
* the session will call Partial handler to process the MessagePart.
* So we should not use onMessage func, in ENDPOINT
*
/
