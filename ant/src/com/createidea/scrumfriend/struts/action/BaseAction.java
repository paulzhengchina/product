package com.createidea.scrumfriend.struts.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.createidea.scrumfriend.utils.FileUtil;
import com.createidea.scrumfriend.utils.Pager;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements MethodInterceptor{
	/*
	 * add some usefully method here to facility the development
	 */
	
	 static Logger logger = Logger.getLogger(BaseAction.class.getName());
	// public int currentPage; 
	// public Pager pager;
	 public final static String USER="CRNTUSER";
     private static int BUFFER_SIZE=16*1024;
	 
     public HttpServletRequest getRequest(){
    	 
    	return  ServletActionContext.getRequest();
     }
     
     public HttpSession getSession(){
    	 return getRequest().getSession();
    	 
     }

	 public String getLan(){
		 Locale rl=this.getRequest().getLocale();
		 Locale sl=(Locale)this.getSession().getAttribute("WW_TRANS_I18N_LOCALE");
		 String lan="";
		 if(sl!=null){
			 lan=sl.getLanguage();
			
		 }
		 else
			 lan=rl.getLanguage(); 
		 return lan;
	 }

	public static String getLocalIP(){
		InetAddress LocalIP=null; 
		try{ 
		LocalIP=InetAddress.getLocalHost(); 
		return LocalIP.getHostAddress();
		} 
		catch(UnknownHostException e){} 
		return "";
		} 

	public String getApplicationRootPath()
	{
		return getSession().getServletContext().getRealPath("/") ;
	}
	
//	public Pager getPager() {
//		return pager;
//	}
//
//	public void setPager(Pager pager) {
//		this.pager = pager;
//	}
//
//	public int getCurrentPage() {
//		return currentPage;
//	}
//
//	public void setCurrentPage(int currentPage) {
//		this.currentPage = currentPage;
//	}

	
	public Object invoke(MethodInvocation methodinvoke) throws Throwable {
		// TODO Auto-generated method stub
		String loginfo="";
		Method method=methodinvoke.getMethod();
		String classname=method.getDeclaringClass().getName();
		method.getName();
		try {
			Object[] args=methodinvoke.getArguments();
			if(args!=null&&args.length>0)
			{
				for(int i=0;i<args.length;i++){
					loginfo+=args[i].getClass().getName()+" ; ";
					loginfo+=args[i].toString();
					loginfo+="   ;   ";
				}
			}
			
			
			Object returnValue = methodinvoke.proceed();
			
			return returnValue;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
			return null;
		}
	}

	
	
	}
     
     

