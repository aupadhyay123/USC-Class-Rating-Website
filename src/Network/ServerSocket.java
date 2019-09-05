package Network;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
//import java.util.Vector;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/appEndpoint")					//let TomCat know that this class is a Server Endpoint
public class ServerSocket {

	private static HashMap<Session, Integer> map = new HashMap<Session,Integer>();
	//4 events can occur with client --> connect, disconnect, message, or error
	//Session --> contains a consistent inputStream and outputStream
	
	@OnOpen											//add annotations above all methods as well
	public void open(Session session) {
		
		Map<String,List<String>> params = session.getRequestParameterMap(); //getPathParameters();
		for (String i : params.keySet()) {
			System.out.println(i + " : " + params.get(i).get(0));
		}
		int id = Integer.parseInt(params.get("id").get(0));
		System.out.println("Connected with id " + id + "!");
		
		map.put(session, id);
		
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {
		Integer id = 0;
		String toSend = "";
		
		if(message.contains("request: ")) {
			String temp = message.substring(9);
			id = Integer.parseInt(temp);
		}
		for (Session s : map.keySet()) {
			if((Integer)map.get(s) == id) {
				System.out.println("Sending messgae to id: " + id);
				try {
					s.getBasicRemote().sendText("Go check out your Profile.\n You have a new friend request.");
				} catch (IOException ioe) {
					System.out.println("ioe: " + ioe.getMessage());
				}	
			}
		}
	}
	
	@OnClose
	public void close(Session session) {
		System.out.println("Disonnected!");
		//sessionVector.remove(session);			//removes a connection from the server
		map.remove(session);
	}
	
	@OnError
	public void error(Throwable error) {	//Throwable --> parent of Exception
		System.out.println("Error!");

		
	}

}
