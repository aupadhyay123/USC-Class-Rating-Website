package Network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

public class Client extends Thread {

	public InputStreamReader isr = null;
	public BufferedReader br = null;
	public PrintWriter pw = null;
	public HttpSession session = null;
	Socket s = null;
	
	public void sendMessage(String message) {
		pw.println(message);
		pw.flush();
	}
	
//	public void setUser(User current) {
//		
//	}
	
	public Client(String hostname, int port, HttpSession curr) {
		try {
			System.out.println("Client now trying to connect to " + hostname + ":" + port);
			s = new Socket(hostname, port); 
			System.out.println("Client successfully connected to " + hostname + ":" + port);
			
			session = curr;
			isr = new InputStreamReader(s.getInputStream());
			br = new BufferedReader(isr);
			pw = new PrintWriter(s.getOutputStream());
			
		} catch (IOException ioe) {
			System.out.println("Client iod: " + ioe.getMessage());
		}
		
		this.start();
		
	}
	
	public void run() {
	
		try {
			while(true) {
				String line = br.readLine();
				System.out.println("In Client: " + line);
			}
			
		} catch (IOException ioe) {
			System.out.println("ioe: " + ioe.getMessage());
		} finally {
			try {
				if(pw != null)
					pw.close();
				if(br != null)
					br.close();
				if(isr != null)
					isr.close();
				if(s != null)
					s.close();
			}catch(IOException ioe) {
				System.out.println("ioe: " + ioe.getMessage());
			}
		}
		
	}
}
