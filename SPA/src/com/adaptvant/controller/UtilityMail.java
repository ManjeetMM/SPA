package com.adaptvant.controller;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class UtilityMail 
{
	static Properties props=new Properties();
	static Session session = Session.getInstance(props, null);
	
	public static void email(String recipientEmail)
	{
		
		
		try {  
			MimeMessage message = new MimeMessage(session);  
			message.setFrom(new InternetAddress("manjeet.murari@a-cti.com", "Manjeet Varification"));
			message.addRecipient(Message.RecipientType.TO,new InternetAddress(recipientEmail));  
			message.setSubject("For Email Verification");  
			String msg="<h1>Hello User </h1><br/>"+
			"Your Email :</b> "+ recipientEmail +"\n\n"+"<br/><a href='http://angularproject.appspot.com/verified?userid="+recipientEmail+"'> Click Here </a>  Here to validate <br/><br/>";
			
			message.setContent(msg,"text/html; charset=utf-8");
			//send message  
			Transport.send(message);  
			  
			System.out.println("message sent successfully");  
			   
		} 
		catch (Exception e) {
			throw new RuntimeException(e);
		} 
		
	}

}
