package com.createidea.scrumfriend.utils.commonmail;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Collection;

import javax.mail.internet.*;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class SendMail {
  
	private static class MailInfo{
		static final String Host = "smtp.exmail.qq.com";
		static final String EMAILUSER="noreply@antkanban.com";
		static final String EMAILPASSWORD="password";
		static final String SENDERNAME="Small Ant";
	}
	
	public void Send(Collection<InternetAddress> receivers,String subject,String htmlFielPath)
	{
		 try {
			 HtmlEmail email = new HtmlEmail();
			 email.setHostName(MailInfo.Host);
			 email.setAuthentication(MailInfo.EMAILUSER,MailInfo.EMAILPASSWORD);
			 email.setFrom(MailInfo.EMAILUSER, MailInfo.SENDERNAME);
			 email.setTo(receivers);
			 email.setSubject(subject);
			 email.setCharset("utf-8");
			 email.setHtmlMsg(ConvertHtmlToMailContent(htmlFielPath));
			 email.send();
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String ConvertHtmlToMailContent(String path)
	{
		BufferedReader br=null;
		try {
			br = new BufferedReader(new FileReader(path)); 
			StringBuffer buffer = new StringBuffer();
			String data = br.readLine();//一次读入一行，直到读入null为文件结束  
			while( data!=null){  
			      System.out.println(data);  
			      data = br.readLine(); //接着读下一行  
			      buffer.append(data);
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		finally
		{
		   try {
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return br.toString();
	}
	
}
