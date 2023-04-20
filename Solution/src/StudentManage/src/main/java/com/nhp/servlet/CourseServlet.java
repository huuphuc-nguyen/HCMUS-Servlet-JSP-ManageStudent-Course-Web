package com.nhp.servlet;

import com.nhp.entity.*;
import com.google.gson.Gson;
import com.nhp.context.*;
import com.nhp.dao.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;


/**
 * Servlet implementation class CourseServlet
 */
@WebServlet("/CourseServlet")
public class CourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CourseServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
        CourseDAO dataGetter = new CourseDAO();
        List<Course> courseList = dataGetter.getListCourse();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(courseList));
        out.flush();
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  String courseId = request.getParameter("courseId");
		  String courseName = request.getParameter("courseName");
		  String lecture = request.getParameter("lecture");
		  String year = request.getParameter("year");
		  String note = request.getParameter("note");
		  String action = request.getParameter("action");
		  
		  int int_id = Integer.parseInt(courseId);
		  int int_year = Integer.parseInt(year);
		  
		  Course newCourse = new Course(int_id, courseName, lecture, int_year, note);
		  CourseDAO dataAccess = new CourseDAO();
		  
		  if (action.equals("add")) {
			  dataAccess.addCourse(newCourse);
		  }
		  else if (action.equals("update")) {
			  dataAccess.updateCourse(newCourse);
		  }
		  else if (action.equals("delete")) {
			  dataAccess.deleteCourse(newCourse);
		  }
		 
		  response.setStatus(HttpServletResponse.SC_OK);
		  //response.sendRedirect("courses.jsp");
	}


}
