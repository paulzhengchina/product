package com.createidea.scrumfriend.utils;

/***************************************************************************
 * 
 * Copyright (c) 2012 Baidu.com, Inc. All Rights Reserved
 * 
 **************************************************************************/
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.baidu.inf.iis.bcs.BaiduBCS;
import com.baidu.inf.iis.bcs.auth.BCSCredentials;
import com.baidu.inf.iis.bcs.auth.BCSSignCondition;
import com.baidu.inf.iis.bcs.http.HttpMethodName;
import com.baidu.inf.iis.bcs.model.BCSClientException;
import com.baidu.inf.iis.bcs.model.BCSServiceException;
import com.baidu.inf.iis.bcs.model.BucketSummary;
import com.baidu.inf.iis.bcs.model.Empty;
import com.baidu.inf.iis.bcs.model.ObjectListing;
import com.baidu.inf.iis.bcs.model.ObjectMetadata;
import com.baidu.inf.iis.bcs.model.ObjectSummary;
import com.baidu.inf.iis.bcs.model.Resource;
import com.baidu.inf.iis.bcs.model.SuperfileSubObject;
import com.baidu.inf.iis.bcs.model.X_BS_ACL;
import com.baidu.inf.iis.bcs.policy.Policy;
import com.baidu.inf.iis.bcs.policy.PolicyAction;
import com.baidu.inf.iis.bcs.policy.PolicyEffect;
import com.baidu.inf.iis.bcs.policy.Statement;
import com.baidu.inf.iis.bcs.request.CreateBucketRequest;
import com.baidu.inf.iis.bcs.request.GenerateUrlRequest;
import com.baidu.inf.iis.bcs.request.GetObjectRequest;
import com.baidu.inf.iis.bcs.request.ListBucketRequest;
import com.baidu.inf.iis.bcs.request.ListObjectRequest;
import com.baidu.inf.iis.bcs.request.PutObjectRequest;
import com.baidu.inf.iis.bcs.request.PutSuperfileRequest;
import com.baidu.inf.iis.bcs.response.BaiduBCSResponse;
public class BaiduStoreService {
	static String host = "bcs.duapp.com";
	static String accessKey = "VGnGMrjBp8864jmdPs1mdxiq";
	static String secretKey = "jhm1jt1ONXOnwu30K8VfzqFuL0PGxzv3";
	static String bucket = "kanbanservice";
	// ----------------------------------------
	static String object = "/2-object";
	static File destFile = new File("test");
	static BaiduBCS baiduBCS;
	/**
	 * @param args
	 */
	static{
		BCSCredentials credentials = new BCSCredentials(accessKey, secretKey);
		baiduBCS = new BaiduBCS(credentials, host);
		// baiduBCS.setDefaultEncoding("GBK");
		baiduBCS.setDefaultEncoding("UTF-8"); // Default UTF-8
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		putObjectByFile(object,createSampleFile());
		System.out.println(getObjectUrl(object));
	}
	
	public static String storeFileToBaiduCloud(String targetName,File uploadedFile){
		putObjectByFile(targetName,uploadedFile);
		return getObjectUrl(targetName);
	}
	public static void putObjectByFile(String targetName,File uploadedFile) {
		PutObjectRequest request = new PutObjectRequest(bucket, targetName, uploadedFile);
		ObjectMetadata metadata = new ObjectMetadata();
		// metadata.setContentType("text/html");
		request.setMetadata(metadata);
		BaiduBCSResponse<ObjectMetadata> response = baiduBCS.putObject(request);
		baiduBCS.putObjectPolicy(bucket, object, X_BS_ACL.PublicRead);
	}
	
	public static String getObjectUrl(String targetName){
		GenerateUrlRequest generateUrlRequest = new GenerateUrlRequest(HttpMethodName.GET, bucket, targetName);
		return baiduBCS.generateUrl(generateUrlRequest);
	}
	
	private static File createSampleFile() {
		try {
			File file = File.createTempFile("java-sdk-", ".txt");
			file.deleteOnExit();

			Writer writer = new OutputStreamWriter(new FileOutputStream(file));
			writer.write("01234567890123456789\n");
			writer.write("01234567890123456789\n");
			writer.write("01234567890123456789\n");
			writer.write("01234567890123456789\n");
			writer.write("09999567890123456789\n");
			writer.close();

			return file;
		} catch (IOException e) {
			return null;
		}
	}

}
