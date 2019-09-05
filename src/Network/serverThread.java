package Network;

import java.net.Socket;
import LogReg.User;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

public class serverThread extends Thread {

	public Server server = null;
	public Socket socket = null;
	public User loggedIn = null;
	public String currentPage = null;
	
	public InputStreamReader isr = null;
	public BufferedReader br = null;
	public PrintWriter pw = null;
	
	public serverThread(Server serv, Socket s) {
			
		this.socket = s;
		this.server = serv;
		this.currentPage = "homePage.jsp";
		
		try {
			pw = new PrintWriter(new BufferedOutputStream(s.getOutputStream()));
			br = new BufferedReader(new InputStreamReader(s.getInputStream()));
			this.start();
		} catch (IOException ioe) {
			System.out.println("serverThread ioe: " + ioe.getMessage());
		}
		
	}
	
	public void run() {
		
		while (true) {
			try {
				while(true) {
					String line = br.readLine();
					System.out.println("In serverThread: " + line);
					
					if(line.contains("logged in as")) {
						
					}
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
				}catch(IOException ioe) {
					System.out.println("ioe: " + ioe.getMessage());
				}
			}
			
		}
		
	}
}
