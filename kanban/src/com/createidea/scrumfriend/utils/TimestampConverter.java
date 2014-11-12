package com.createidea.scrumfriend.utils;

import java.sql.Timestamp;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

import com.opensymphony.xwork2.XWorkException;

public class TimestampConverter extends StrutsTypeConverter {  
    
    public Object convertFromString(Map map, String as[], Class class1) {  
        return parseStringToTimestamp(as[0]);  
    }  
  
    public String convertToString(Map map, Object obj) {  
        String s = null;  
        if (obj instanceof Timestamp) {  
            String s1 = obj.toString();  
            s = s1.substring(0, 19);  
        }  
        return s;  
    }  
  
    private Timestamp parseStringToTimestamp(Object obj) {  
        Timestamp timestamp = null;  
        if (obj instanceof String)  
            try {  
                timestamp = Timestamp.valueOf((String) obj);  
            }  
            catch (Exception exception) {  
                throw new XWorkException("Could not parse Timestamp", exception);  
            }  
        return timestamp;  
    }  
}  