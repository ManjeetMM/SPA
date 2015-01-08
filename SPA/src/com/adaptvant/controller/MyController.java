package com.adaptvant.controller;

//import java.io.IOException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.mortbay.log.Log;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.sun.istack.internal.logging.Logger;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

@Controller
public class MyController {
	//private static final Logger log=Logger.getLogger(MyController.class.getName());
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/reg", method = RequestMethod.POST)
	public @ResponseBody Map<String, String> m1(@RequestBody String request, HttpServletRequest req)throws Exception
	{
		System.out.println(request);
		Map<String, String> obj = new HashMap<String, String>();

		try {
			ObjectMapper objectmapper = new ObjectMapper();
			Student student = objectmapper.readValue(request, Student.class);

			String name = student.getName();
			String email = student.getEmail();
			String gender = student.getGender();
			String password = student.getPassword();
			// ============================================================//

			Key k = KeyFactory.createKey("Student", email);

			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

			Filter filter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY,
					FilterOperator.EQUAL, k);
			Query q = new Query("Student").setFilter(filter);

			PreparedQuery pereparequery = datastore.prepare(q);

			if (!(pereparequery.countEntities() > 0)) {

				Entity register = new Entity("Student", email);
				register.setProperty("Name", name);
				register.setProperty("Sex", gender);
				register.setProperty("Email", email);
				register.setProperty("Password", password);// Temporary password
				register.setProperty("Image", "nothing");
				datastore.put(register);
		

				// =========Email
				// Function============================================//
				System.out.println("Inside Mailing services");

				UtilityMail.email(email);
				// ===========call end===================//

				// ======Session=======//
				HttpSession session1 = req.getSession();
				session1.setAttribute("name", name);
				session1.setAttribute("gender", gender);
				session1.setAttribute("email", email);
				session1.setAttribute("password", password);
				session1.setAttribute("Image", "nothing");
				// ======Session=======//

				obj.put("sucess", "sucess");
				System.out.println("puting sucess ");
			} else {
				System.out.println(": Allready Registerd : ");

			}

			// ===========================================================//
		} catch (Exception e) {
			e.printStackTrace();
		}

		return obj;

	}

	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody Map<String, String> login(@RequestBody String request, HttpServletRequest req, HttpServletResponse resp)throws IOException 
	{
		HttpSession ses = req.getSession();
		Map<String, String> obj = new HashMap<String, String>();

		/*if (ses.getAttribute("name") == null) {*/
			System.out.println("inside session checking");
			try {
				ObjectMapper objectmapper = new ObjectMapper();
				Student student = objectmapper.readValue(request, Student.class);

				String email = student.getEmail();
				System.out.println(email);
				String password = student.getPassword();
              /*if(!password.equals("Temp"))
              {*/
				DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

				Query q = new Query("Student").addFilter("Email",Query.FilterOperator.EQUAL, email).addFilter("Password", Query.FilterOperator.EQUAL, password);
				PreparedQuery pq = ds.prepare(q);
				// =========******=============//

				if (pq.countEntities() > 0) {

					for (Entity e : pq.asIterable()) {

						// ==============Session===============//

						ses.setAttribute("name", e.getProperty("Name"));
						ses.setAttribute("email", e.getProperty("Email"));
						ses.setAttribute("gender", e.getProperty("Sex"));
						// ==============image session====================//
						ses.setAttribute("Image", e.getProperty("Image"));//
						// ================================================//
						System.out.println("in login printing session"
								+ ses.getAttribute("gender"));
						// =============session======================//

						System.out.println("inside for loop");

						System.out.println("After Filtering You Loged In :");
						//==================//
						ses.setAttribute("page", "ToDolist.jsp");
						//==================//
						obj.put("Student", "Successfuly Loged In");
						
						obj.put("sucess", "sucess");

					}
				} else {
					System.out.println("Sorry Not Loged In  :");
					obj.put("sucess", "Sorry Wrong Id Or Password ");

				}
             /* }
              else
              {
            	  System.out.println("Sorry u have to register First");
            	  obj.put("sucess","Sorry Wrong Id or Password");
              }*/

			} // try block ends here //

			catch (Exception e) {
				e.printStackTrace();
			}
			return obj;
		}/* else {
			System.out
					.println("Session is there so redirecting to the page logedin page ");
			resp.sendRedirect("http://seventhapplication.appspot.com/jsp/Logedin.jsp");
			return obj;
		}
	}*/

	// ==================*LOGOUT*=================//

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public @ResponseBody Map<String, String> logout(@RequestBody String request,HttpServletRequest req) 
	{
		Map<String, String> obj1 = new HashMap<String, String>();
		req.getSession().invalidate();
		obj1.put("logout", "logout");
		return obj1;
	}

	// =================*LOGOUT()-End*===============//

	// ====================* Update Method *===============//
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/updatep", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, String> update(@RequestBody String request,
			HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		Map<String, String> obj = new HashMap<>();

		HttpSession ses = req.getSession();
		String email = ses.getAttribute("email").toString();
		System.out.println(email);
		String gender = ses.getAttribute("gender").toString();
		System.out.println(" inside updating function :" + gender);
		try {
			ObjectMapper objm = new ObjectMapper();
			Student student = objm.readValue(request, Student.class);

			String newName = student.getName();
			String NewPassword = student.getPassword();

			System.out.println("New Name=" + newName + " New Pasword:="
					+ NewPassword);

			// =========================Data Query======================//
			if (!newName.equals("") && !NewPassword.equals("")) {
				/* Key k=KeyFactory.createKey("Student", email); */
				DatastoreService ds = DatastoreServiceFactory
						.getDatastoreService();
				Query q = new Query("Student").addFilter("Email",
						Query.FilterOperator.EQUAL, email);
				PreparedQuery pq = ds.prepare(q);

				if (pq.countEntities() > 0)

				{
					System.out.println("inside updation");
					Entity register = new Entity("Student", email);
					register.setProperty("Name", newName);
					register.setProperty("Sex", gender);
					register.setProperty("Email", email);
					register.setProperty("Password", NewPassword);
					ds.put(register);

					ses.setAttribute("name", register.getProperty("Name"));
					ses.setAttribute("email", register.getProperty("Email"));
					ses.setAttribute("gender", register.getProperty("Sex"));
					ses.setAttribute("password",register.getProperty("Password"));
				}

				// =========================Data Query======================//
				obj.put("update", "update");

			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return obj;
	}

	// ====================*******End Of Update Method**********===============//

	@RequestMapping("/index")
	public @ResponseBody Map<String, String> index(@RequestBody String request,HttpServletRequest req, HttpServletResponse res) throws IOException {
		Map<String, String> ob = new HashMap<>();
		System.out.println("Inside the servlet where i valadating");
		HttpSession session = req.getSession();
		System.out.println("Email inside session: "+ session.getAttribute("email"));
		if (session.getAttribute("email") != null &&  ! (session.getAttribute("password").toString().equals("Temp")))
		// if(!(session.getAttribute("password").equals("Temp")) &&
		// (session.getAttribute("email")!=null))
		{
			
			ob.put("success", "success");
			return ob;
		} else {
			System.out.println("to the index page:");
			
			ob.put("success", "unsucess");
			return ob;
		}

	}

	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/verified", method = RequestMethod.GET)  // ,params={"userid"}
	@ResponseBody public ModelAndView confirm(@RequestParam("userid") String id,HttpServletRequest req, HttpServletResponse resp)throws IOException 
	{
		System.out.println("inside verification");
		String email = id;
		System.out.println(email);
		HttpSession session = req.getSession();
		System.out.println("Your id is:" + email);
		ModelAndView modelObject;
		
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Query q = new Query("Student").addFilter("Email",Query.FilterOperator.EQUAL, email).addFilter("Password",Query.FilterOperator.EQUAL, "Temp");
		PreparedQuery pq = ds.prepare(q);
		if (pq.countEntities() > 0) {
			session.setAttribute("email", email);
			modelObject = new ModelAndView("Confirm");
			modelObject.addObject("email", email);
			return modelObject;
		} 
		else 
		{
			resp.sendRedirect("http://angularproject.appspot.com/jsp/Login.jsp");// making
																					// changes
																					// here
			modelObject = new ModelAndView("Login");
			modelObject.addObject("email", "Not authorized");
			return modelObject;
		}
	}

	@RequestMapping(value = "/insertpassword", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, String> insertp(@RequestBody String request,
			HttpServletRequest req, HttpServletResponse res) {
		Map<String, String> obj = new HashMap<>();
		HttpSession s = req.getSession();

		try {
			ObjectMapper objectmapper = new ObjectMapper();
			Student student = objectmapper.readValue(request, Student.class);

			String password = student.getPassword();
			String email = s.getAttribute("email").toString();
			System.out.println(email);
			String newGender = null;
			String newName = null;
			Key k = KeyFactory.createKey("Student", email);

			DatastoreService datastore = DatastoreServiceFactory
					.getDatastoreService();

			Filter filter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY,
					FilterOperator.EQUAL, k);
			Query q = new Query("Student").setFilter(filter);

			PreparedQuery pereparequery = datastore.prepare(q);

			if ((pereparequery.countEntities() > 0)) {
				System.out.println("inside the data query");

				for (Entity e : pereparequery.asIterable()) {
					newName = e.getProperty("Name").toString();
					newGender = e.getProperty("Sex").toString();

				}
			}

			if ((pereparequery.countEntities() > 0)) {

				Entity register = new Entity("Student", email);
				register.setProperty("Name", newName);
				register.setProperty("Sex", newGender);
				register.setProperty("Email", email);
				register.setProperty("Password", password);
				datastore.put(register);

				s.setAttribute("name", register.getProperty("Name"));
				s.setAttribute("email", register.getProperty("Email"));
				s.setAttribute("gender", register.getProperty("Sex"));
				s.setAttribute("password", register.getProperty("Password"));

				obj.put("success", "success");
			} else
				obj.put("success", "failed");

		}

		catch (Exception e) {
			e.printStackTrace();
		}

		return obj;
	}

	@RequestMapping(value = "/cn", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, String> cn(@RequestBody String request, HttpServletRequest req,
			HttpServletResponse res) throws IOException {
		Map<String, String> ob = new HashMap<>();
		HttpSession se = req.getSession();
		String password = se.getAttribute("password").toString();

		if (password.equals("Temp")) {

			ob.put("success", "no");
		} else {
			res.sendRedirect("http://angularproject.appspot.com/jsp/Logedin.jsp");
			ob.put("success", "success");

		}
		return ob;
	}

	@RequestMapping(value = "/uploadimg", method = RequestMethod.POST)
	public void img(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		HttpSession session = req.getSession();
		String email = session.getAttribute("email").toString();
		String password = req.getParameter("password");//
		String name = session.getAttribute("name").toString();
		String gender = session.getAttribute("gender").toString();
		System.out.println(password);
		// String email="manjeet.murari@a-cti.com";

		BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		
		List<BlobKey> l = blobs.get("myFile");
		// BlobKey blobKey = blobs.get("myFile");
		BlobKey blobkey = l.get(0);
		System.out.println(blobkey); ///******
	     
		BlobInfo info = new BlobInfoFactory().loadBlobInfo(blobkey);

		// This just gives the user's filename like "manjeet.jpg":
		 String fname=info.getFilename();
		info.getSize();
		System.out.println(info.getSize());
		
		if (info.getSize() <= 0) 
		{
			
			Key k = KeyFactory.createKey("Student", email);

			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

			Filter filter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY,FilterOperator.EQUAL, k);
			Query q = new Query("Student").setFilter(filter);

			PreparedQuery ps = datastore.prepare(q);

			if (ps.countEntities() > 0) {
				for (Entity e : ps.asIterable()) 
				{
					Entity register = new Entity("Student", email);
					register.setProperty("Email", email);
					register.setProperty("Name", name);
					register.setProperty("Password", password);
					register.setProperty("Sex", gender);
					register.setProperty("Image", "nothing");

					datastore.put(register);
					session.setAttribute("password", password);
					session.setAttribute("name",name);
					session.setAttribute("Image", "nothing");
					res.sendRedirect("http://angularproject.appspot.com/jsp/Logedin.jsp");
				}
			}

		} 
		else {

			Key k = KeyFactory.createKey("Student", email);

			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

			Filter filter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY,FilterOperator.EQUAL, k);
			Query q = new Query("Student").setFilter(filter);

			PreparedQuery ps = datastore.prepare(q);

			if (ps.countEntities() > 0) {
				for (Entity e : ps.asIterable()) {
					System.out.println(" Image is going to store in the Data store");// /****

					System.out.println("creating the image column");// //*****

					Entity register = new Entity("Student", email);
					register.setProperty("Email", email);
					register.setProperty("Name", name);
					register.setProperty("Password", password);
					register.setProperty("Sex", gender);
					register.setProperty("Image", blobkey);

					datastore.put(register);
					session.setAttribute("password", password);
					session.setAttribute("Image", blobkey);
					session.setAttribute("name",name);
					res.sendRedirect("http://angularproject.appspot.com/jsp/Logedin.jsp");

				}
			}

		}
	

	}

	// =============

	
	 @RequestMapping (value="/getbloburl")
	 public @ResponseBody String blobURL()
	 {
		 BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService(); 
		 return blobstoreService.createUploadUrl("/updatingimg");
	 }
	
	
	@RequestMapping(value = "/updatingimg", method = RequestMethod.POST)
	@ResponseBody public Map<String ,String> img1 (/*@RequestBody String re,*/ HttpServletRequest req) throws Exception
	{
		HttpSession session = req.getSession();
		Map<String ,String> obmp=new HashMap<>();
		
		ObjectMapper objectmapper = new ObjectMapper();
		
		 System.out.println("name");
	
        System.out.println("Blob Strore service");
		BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		List<BlobKey> l = blobs.get("myFile");
		BlobKey blobkey = l.get(0);
		System.out.println(blobkey);// /******
		if (blobkey == null)
		{
		  obmp.put("unsucess", "null value");
          
		} 
		else 
		{
			Key k = KeyFactory.createKey("Student", "manjeet.murari@a-cti.com"/*email*/);
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Filter filter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY,FilterOperator.EQUAL, k);
			Query q = new Query("Student").setFilter(filter);
             
			PreparedQuery ps = datastore.prepare(q);

			   if (ps.countEntities() > 0) 
			   {
				    for (Entity e : ps.asIterable()) 
				   {
					
					Entity register = new Entity("Student", "manjeet.murari@a-cti.com"/*email*/);
					register.setProperty("Email", "manjeet.murari@a-cti.com"/*email*/);
					register.setProperty("Name","Manjeet " /*name*/);
					register.setProperty("Password","manjeet123" /*password*/);
					register.setProperty("Sex","Male" /*gender*/);
					register.setProperty("Image", blobkey);

					datastore.put(register);
					//session.setAttribute("password", password);
					session.setAttribute("Image", blobkey);
					//session.setAttribute("name", name);
					System.out.println("putting the image in session");
					ImagesService imagesService = ImagesServiceFactory.getImagesService();
					String url=imagesService.getServingUrl(blobkey);
					obmp.put("success",url);
					 
				}
					
			}
		}
	return obmp;
	}
	



	// ============= End Here 14/10/2014=======================//
	
	@RequestMapping("/something")
	@ResponseBody public ToDo angular(@RequestBody String sm,HttpServletRequest req) throws JsonParseException, JsonMappingException, IOException
	{
		HttpSession ses=req.getSession();
		
		ToDo obj1=new ToDo();
		ObjectMapper objectmapper=new ObjectMapper();
		ToDo todo=objectmapper.readValue(sm, ToDo.class);
		System.out.println("ToDo Name :"+todo.getName()+" ToDo Status : "+todo.getStatus()+"Todo Date"+todo.getDate()+" Todo Time "+todo.getTime());
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		Entity register=new Entity("ToDo",todo.getName());
		register.setProperty("Task", todo.getName());
		register.setProperty("Status", todo.getStatus());
		register.setProperty("Email",ses.getAttribute("email").toString());
		register.setProperty("Date", todo.getDate());
		register.setProperty("Time", todo.getTime());
		datastore.put(register);
		ses.setAttribute("page", "Logedin.jsp");
		//obj.put("success", "success");
		obj1.setName(todo.getName());
		obj1.setStatus(todo.getStatus());
		obj1.setDate(todo.getDate());
		obj1.setTime(todo.getTime());
		ses.setAttribute("page", "ToDolist.jsp");
		return  obj1;
	}
	
	//======Returning json Data from The Data Base====//
	@RequestMapping("/getData")
	@ResponseBody public ArrayList<ToDo> ang(HttpServletRequest req,HttpServletResponse res) throws Exception
	{
		HttpSession session=req.getSession();
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Query q = new Query("ToDo").addFilter("Email",Query.FilterOperator.EQUAL,session.getAttribute("email")).addFilter("Status", Query.FilterOperator.EQUAL, "pending");
		PreparedQuery pq = ds.prepare(q);
        ArrayList<ToDo> ob=new ArrayList<>(); 
		if (pq.countEntities() > 0)
		{  int i=0;
			for(Entity e:pq.asIterable())
			{  ToDo to=new ToDo();
			   to.setName((String) e.getProperty("Task"));
			   to.setStatus(e.getProperty("Status").toString());
			   to.setDate(e.getProperty("Date").toString());
			   to.setTime(e.getProperty("Time").toString());
				ob.add(i,to);
				i++;
			}
			
		}
		return ob;		
	}
	

	
	
	@RequestMapping(value = "/updatename", method = RequestMethod.POST)
	@ResponseBody public Map<String ,String> name (@RequestBody String re, HttpServletRequest req) throws Exception
	{
		HttpSession session = req.getSession();
		Map<String ,String> obmp=new HashMap<>();
		
		ObjectMapper objectmapper = new ObjectMapper();
		Student student = objectmapper.readValue(re, Student.class);
		String name=student.getName();
		String password=student.getPassword();
		String email=session.getAttribute("email").toString();
		String gender=session.getAttribute("gender").toString();
		//String Image=session.getAttribute("Image").toString();
		BlobKey bk=(BlobKey)session.getAttribute("Image");
		//=========
		Key k = KeyFactory.createKey("Student", email);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter filter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY,FilterOperator.EQUAL, k);
		Query q = new Query("Student").setFilter(filter);
         
		PreparedQuery ps = datastore.prepare(q);

		   if (ps.countEntities() > 0) 
		   {
			    for (Entity e : ps.asIterable()) 
			   {
				
				Entity register = new Entity("Student", email);
				register.setProperty("Email", email);
				register.setProperty("Name", name);
				register.setProperty("Password",password);
				register.setProperty("Sex",gender );
				register.setProperty("Image", bk);
				datastore.put(register);
				
				session.setAttribute("password", password);
				session.setAttribute("email", email);
				
				session.setAttribute("name", name);
				
				obmp.put("name",name);
				 
			}
				
		}
		
		//========= 
		//session.setAttribute("name", name);
		//obmp.put("name", name);
		return  obmp;
	}
	
	
	
	//=================================27/10/2014=============================//
	@RequestMapping("/getCompleted")
	@ResponseBody public ArrayList<ToDo> completed(HttpServletRequest req,HttpServletResponse res) throws Exception
	{
		HttpSession session=req.getSession();
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Query q = new Query("ToDo").addFilter("Email",Query.FilterOperator.EQUAL,session.getAttribute("email")).addFilter("Status", Query.FilterOperator.EQUAL, "completed");
		PreparedQuery pq = ds.prepare(q);
        ArrayList<ToDo> ob=new ArrayList<>(); 
		if (pq.countEntities() > 0)
		{  int i=0;
			for(Entity e:pq.asIterable())
			{  ToDo to=new ToDo();
			   to.setName((String) e.getProperty("Task"));
			   to.setStatus(e.getProperty("Status").toString());
			   to.setDate(e.getProperty("Date").toString());
			   to.setTime(e.getProperty("Time").toString());
			   System.out.println("Date is when returning completed list :"+e.getProperty("Date").toString());
				ob.add(i,to);
				i++;
			}
			
		}
		return ob;		
	}
	
	//=======================================================================//
	
	
	
	@RequestMapping("/Datadate")
	@ResponseBody public Map<String ,String> sm(@RequestBody String sn,HttpServletRequest req,HttpServletResponse res) throws Exception
	{
		Map mp=new HashMap<>();
		HttpSession session=req.getSession();
		ObjectMapper objectmapper = new ObjectMapper();
		Student student = objectmapper.readValue(sn, Student.class);
		String task=student.getName();
		System.out.println("Name Of the  task whose date we want :"+task);
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Query q = new Query("ToDo").addFilter("Email",Query.FilterOperator.EQUAL,session.getAttribute("email")).addFilter("Task", Query.FilterOperator.EQUAL, task);
		PreparedQuery pq = ds.prepare(q);
        
		if (pq.countEntities() > 0)
		{ 
			for(Entity e:pq.asIterable())
			{
				System.out.println(e.getProperty("Date"));
			     mp.put("date", e.getProperty("Date") );
			     mp.put("time", e.getProperty("Time"));
			}
		}
			
		
		return mp;		
	}

}
