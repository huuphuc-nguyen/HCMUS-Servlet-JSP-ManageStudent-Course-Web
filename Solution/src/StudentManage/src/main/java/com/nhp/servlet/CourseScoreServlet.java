package com.nhp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.nhp.dao.CourseScoreDAO;
import com.nhp.entity.CourseScore;

@WebServlet("/CourseScoreServlet")
public class CourseScoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CourseScoreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	String id = request.getParameter("id");
    	int int_id = 0;
    	
    	if (id != null) {
        	int_id = Integer.parseInt(id);
    	}
    	
    	CourseScoreDAO dataGetter = new CourseScoreDAO();
        List<CourseScore> courseList = dataGetter.getListCourseScore(int_id);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(courseList));
        out.flush();
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String studentId = request.getParameter("studentId");
		String courseId = request.getParameter("courseId");
		String score = request.getParameter("score");
		String action = request.getParameter("action");
		  
		int int_studentId = Integer.parseInt(studentId);
		int int_courseId = Integer.parseInt(courseId);
		float float_score = Float.parseFloat(score);
		
		  
		 CourseScore newCourseScore = new CourseScore(int_studentId, int_courseId, float_score);
		 CourseScoreDAO dataAccess = new CourseScoreDAO();
		  
		  if (action.equals("add")) {
			  dataAccess.addCourseScore(newCourseScore);
		  }
		  else if (action.equals("update")) {
			  dataAccess.updateCourseScore(newCourseScore);
		  }
		  else if (action.equals("delete")) {
			  dataAccess.deleteCourseScore(newCourseScore);
		  }
		 
		  response.setStatus(HttpServletResponse.SC_OK);
		  //response.sendRedirect("courses.jsp");
	}

}
