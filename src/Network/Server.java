package Network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashSet;

public class Server {
	
	//public HashMap<>
	public String path = new String();
	public HashSet<serverThread> map = new HashSet<serverThread>();
	public ServerSocket ss;
	
	public Server(int port) {
		
		try {
			System.out.println("Trying to bind to port " + port);
			ss = new ServerSocket(port);		//bind the server to the port but we have to ask the OS if it is ok
			System.out.println("Bound to port " + port);	//if its not okay, we get thrown the IOException (only if another application is listening to that port)
		
			while (true) {
				System.out.println("Trying to connect to a client");
				//Our whole ChatRoom Thread is now moved to the waiting state --> until a client connects to it
				Socket s = ss.accept();		//Waits on this line until a client connects
				serverThread c = new serverThread(this, s);
				map.add(c);
				System.out.println("Client successfully connected: " + s.getInetAddress());
				
			}
			
			
			//s.getInputStream() --> a "file" being passed to you
			//InputStreamReader --> allows us to read byte by byte
			//BufferedReader --> allows us to read line(string) by line(string)
			//PrintWrite --> allows us to send an output to the client
			
//			InputStreamReader isr = new InputStreamReader(s.getInputStream());
//			BufferedReader br = new BufferedReader(isr);
//			PrintWriter pw = new PrintWriter(s.getOutputStream());
//			
//			String line = br.readLine();	//If the client never sends us anything, we will be stuck here
//			System.out.println("Server Received: " + line);
			//pw.println("Thanks for sending me a message!");	//send a successfully received message back to client
				//Writing this message into memory in the Network Buffer
			//pw.flush();	//So that the message is for sure sent from one program to another (so that it shows up on the the other program)
			
//			br.close(); //better practice to instantiate these before the try block
//			pw.close();	//then close them in a finally block 
//			s.close();	//(so they are closed even if exception is thrown)
			//ss.close();
			
		} catch(IOException ioe) {
			System.out.println(ioe.getMessage());
		} finally {
//			try {
//				//ss.close();
//			} catch (IOException ioe) {
//				System.out.println("Server ioe: " + ioe.getMessage());
//			}
			
		}
	}
}
