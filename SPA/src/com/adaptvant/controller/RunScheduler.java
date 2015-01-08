package com.adaptvant.controller;

import java.util.Date;
import org.springframework.scheduling.annotation.Scheduled;
 

public class RunScheduler {
 
 @Scheduled(cron="0 0 * * * *")
  public void run() {
 
 try{
 
	String dateParam = new Date().toString();
 
	System.out.println("Date is : "+dateParam);
 
    } 
    catch (Exception e) 
    {
	e.printStackTrace();
    }
 
  }
}