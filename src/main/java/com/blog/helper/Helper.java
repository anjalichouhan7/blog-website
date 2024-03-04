package com.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream; 

public class Helper {
	public static boolean deleteFile(String path)
	{
		boolean f=false;
		try {
			//represents path as a file
			File file=new File(path);
			f=file.delete();
			System.out.println(f);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return f;
	}
	
	public static boolean saveFile(InputStream is,String path)
	{
		boolean f=false;
		try {
			//read data from inputstream
			byte b[]=new byte[is.available()];
			
			//read data from is and put it in b
			is.read(b);
			
			//write data
			FileOutputStream fos=new FileOutputStream(path);
			fos.write(b);
			
//			fos.flush();
			fos.close();
			
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
