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
import com.nhp.dao.StudentDAO;
import com.nhp.entity.CourseScore;
import com.nhp.entity.Student;
import com.nhp.entity.StudentInCourse;
import com.nhp.dao.StudentInCourseDAO;


@WebServlet("/StudentInCourseServlet")
public class StudentInCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentInCourseServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		int int_id = 1;
		
		if ( id !=null) {

			int_id = Integer.parseInt(id);
		}
		
		
		StudentInCourseDAO dataGetter = new StudentInCourseDAO();
        List<StudentInCourse> studentList = dataGetter.getListStudentInCourse(int_id);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(studentList));
        out.flush();
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String studentId = request.getParameter("studentId");
		String courseId = request.getParameter("courseId");
		String studentName = request.getParameter("studentName");
		String grade = request.getParameter("grade");
		String birthdate = request.getParameter("birthdate");
		String address = request.getParameter("address");
		String note = request.getParameter("note");
		String score = request.getParameter("score");
		String action = request.getParameter("action");
		  
		int int_studentId = Integer.parseInt(studentId);
		int int_courseId = Integer.parseInt(courseId);
		int int_grade = Integer.parseInt(grade);
		float float_score = Float.parseFloat(score);
		  
		Student newStudent = new Student(int_studentId, studentName, int_grade, birthdate, address, note);
		StudentDAO studentDataAccess = new StudentDAO();
		
		CourseScore newCourseScore = new CourseScore(int_studentId, int_courseId, float_score);
		CourseScoreDAO courseScoreDataAccsess = new CourseScoreDAO();
		  
		if (action.equals("add")) {
			courseScoreDataAccsess.addCourseScore(newCourseScore);
		}
		else if (action.equals("update")) {
			studentDataAccess.updateStudent(newStudent);
			courseScoreDataAccsess.updateCourseScore(newCourseScore);
		}
		else if (action.equals("delete")) {
			courseScoreDataAccsess.deleteCourseScore(newCourseScore);
		}
		 
		response.setStatus(HttpServletResponse.SC_OK);
		
	}

}
