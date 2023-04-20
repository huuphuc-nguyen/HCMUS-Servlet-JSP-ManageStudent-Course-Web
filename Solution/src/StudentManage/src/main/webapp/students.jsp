<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.nhp.entity.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Management</title>

<!-- ... -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
 
    <!-- DevExtreme theme -->
    <link rel="stylesheet" href="https://cdn3.devexpress.com/jslib/22.2.5/css/dx.light.css">
 
    <!-- DevExtreme library -->
    <script type="text/javascript" src="https://cdn3.devexpress.com/jslib/22.2.5/js/dx.all.js"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

	<style>
        .clsbtnCursor {
		    cursor: pointer;
		}
		
        .row {
	        margin-top: 50px;
	    }
	    
	    .myHeader{
	    	color: black;
            text-shadow: 1px 1px 1px rgba(0,0,0,0.5);
            margin-left: 10px;
	    }
        
        #studentsDatagrid {
		  box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
		  padding: 2px;
		  margin-bottom: 2rem;
		}
        
        .flex-container {
		    display: flex;
		    align-items: center; /* center items vertically */
		    justify-content: center;
		  }
        
       .button-add{
       		background-color: transparent;
       		border: none;
       		position: fixed; 
       		top :12rem; 
       		right:3rem;
       }
       
        body {
		    background: radial-gradient(circle at center, #CBF1F5, #E3FDFD);
		}
    </style>


</head>
<body>
	<div class="container text-center mt-5">
	<a></a>
		<div class="flex-container">
		  <img src="https://i.ibb.co/1GLbQKL/home.png" onclick="toMainScreen()" class="clsbtnCursor"/>
		  <h2 class="myHeader">All Students</h2>
		</div>
    	<div class="row">
    		<div id="studentsDatagrid"></div>
    	</div>
    	<script type="text/html" id="content_template">
              <div id="gridInPopup"></div>
        </script>
    	<button class="button-add" onclick=addFunction()><img src="https://i.ibb.co/P5CV0FS/add-button.png" height="30" width="30"/></button>
	</div>
	
	
	<script>
	
	//----------------------------------------------
	function toMainScreen(){
		window.location.href = "main.jsp";
	}
	
	//----------------------------------------------
	function addFunction(){
		$('#studentsDatagrid').dxDataGrid('instance').addRow();
	}
	
	
	//-----------------------------------------------
	 var data1;
	
	 $.ajax({
	      url: "StudentServlet",
	      type: "GET",
	      dataType: "json",
	      success: function(studentList) {
	        data1 = studentList;
	        console.log(data1); // print the updated "data1" variable
	        
	        InitExtreme();
	      },
	      error: function(xhr, textStatus, errorThrown) {
	        console.log(xhr.responseText);
	      }
	    });
	
	 
	//------------------------------------------
	function loadCourse(callback) {
		  $.ajax({
		    url: "CourseServlet",
		    type: "GET",
		    dataType: "json",
		    success: function(courseList) {
		      callback(courseList);
		    },
		    error: function(xhr, textStatus, errorThrown) {
		      console.log(xhr.responseText);
		    }
		  });
		}
	 
	 
	//------------------------------------------
	function InitExtreme(){
		loadCourse(function(courseList) {
			
			$("#studentsDatagrid").dxDataGrid({
	            dataSource: data1,
	            keyExpr: "_studentId",
	            editing: {
	                mode: 'form',
	                form: {
	                    items: [
	                        {
	                            dataField: '_studentId',
	                        },
	                        {
	                            dataField: '_studentName',
	                        },
	                        {
	                            dataField: '_grade',
	                        },
	                        {
	                            dataField: '_birthdate',
	                        },
	                        {
	                        	dataField: '_address',
	                        },
	                        {
	                            dataField: '_note',
	                        },
	                        
	                    ]
	                },
	            },
	            searchPanel: {
	            	visible: true,
	            },
	            scrolling: {
	                mode: "virtual"
	            },
	            showBorders: true,
	            showColumnLines: true,
	            wordWrapEnabled: true,
	            showRowLines: true,
	            remoteOperations: {
	                filtering: true,
	                paging: true,
	                sorting: false,
	                groupPaging: false,
	                grouping: false,
	                summary: true
	            },
	            selection: {
	                mode: 'single',
	                showCheckBoxesMode: 'always',
	                selectAllMode: 'page',
	            },
	            grouping: {
	                autoExpandAll: true,
	            },
	            onRowInserting: function(e) {
	            	var studentData = e.data;
	            	var Nnote = studentData._note;
	            	var newId = e.data._studentId;

	            	if (Nnote == null)
	            		{
	            			Nnote = ' ';
	            		}
	            
	                var existingIds = data1.map(function(item) {
	                    return item._studentId;
	                });
	                
	                if(existingIds.includes(newId)) {
	                    e.cancel = true;
	                    alert("This ID already exists. Please choose a different ID.");
	                }
	                else {
	                	//console.log(studentData._note);
	                	//console.log(studentData._birthdate);
	                	
	                	$.ajax({
	                	    type: 'POST',
	                	    url: 'StudentServlet',
	                	    data: {
	                	      studentId: studentData._studentId,
	                	      studentName: studentData._studentName,
	                	      grade: studentData._grade,
	                	      birthdate: studentData._birthdate,
	                	      address: studentData._address,
	                	      note: Nnote,
	                	      action: 'add'
	                	    },
	                	    success: function(response) {
	                	      console.log('post ok');
	                	    },
	                	    error: function(jqXHR, textStatus, errorThrown) {
	                	    	console.log(textStatus);
	                	    }
	                	  });
	                }
	            },
	            onInitNewRow: function(e) {
	            	e.component.columnOption('IDCol', 'allowEditing', true);
	            },
	            onEditingStart: function(e){
	            	e.component.columnOption('IDCol', 'allowEditing', false);
	            },
	            onRowUpdating: function(e) {
	            	var studentData = e.newData;
	            	var oldStudent = e.oldData;
		           	  
		           	var studentId = oldStudent._studentId;
		           	var studentName = studentData._studentName !== undefined ? studentData._studentName : oldStudent._studentName;
		            var grade = studentData._grade !== undefined ? studentData._grade : oldStudent._grade;
		            var birthdate = studentData._birthdate !== undefined ? studentData._birthdate : oldStudent._birthdate;
		            var address = studentData._address !== undefined ? studentData._address : oldStudent._address;
		            
		            
		            // Check if the note field has been modified
		            var isNoteModified = studentData.hasOwnProperty('_note') && studentData._note !== undefined;
		            
		            // Set the note variable based on the modified status
		            var note = isNoteModified ? studentData._note : oldStudent._note || '';
	            	
	            	if (note === null || note === '')
	            		{
	            			note = ' ';
	            		}
	            	
	            	$.ajax({
	            	    type: 'POST',
	            	    url: 'StudentServlet',
	            	    data: {
	            	      studentId: studentId,
	            	      studentName: studentName,
	            	      grade: grade,
	            	      birthdate: birthdate,
	            	      address: address,
	            	      note: note,
	            	      action: 'update'
	            	    },
	            	    success: function(response) {
	            	      console.log('post ok');
	            	    },
	            	    error: function(jqXHR, textStatus, errorThrown) {
	            	    	console.log(textStatus);
	            	    }
	            	  });
	            },
	            onRowRemoving: function(e) {
	            	var studentData = e.data;
	            	
	            	$.ajax({
	            		type: 'POST',
	            		url: 'StudentServlet',
	            		data: {
	            			studentId: studentData._studentId,
	              	        studentName: studentData._studentName,
	              	        grade: studentData._grade,
	              	        birthdate: studentData._birthdate,
	              	        address: studentData._address,
	              	      	note: studentData._note,
	            			action: 'delete',
	            		},
	            		success: function(response) {
	            			const msg = 'Delete Success';
	            			DevExpress.ui.notify({
	            				message : msg,
	            				width: 300,
	            				position: {
	            					my: 'center top',
	            					at: 'center top',
	            				},
	            			}, 'success', 3000);
	            		},
	            		error: function(jqXHR, textStatus, errorThrown) {
	            			console.log(textStatus);
	            		}
	            	});
	            },
	            columns: [
	                {
	                    caption: 'ID',
	                    width: '7%',
	                    alignment: 'center',
	                    dataField: '_studentId',
	                    name: 'IDCol',
	                    allowEditing: false,
	                    validationRules: [{ type: 'required' }]
	                },
	                {
	                    caption: 'Student Name',
	                    width: '20%',
	                    alignment: 'left',
	                    dataField: '_studentName',
	                    validationRules: [{ type: 'required' }]
	                },
	                {
	                    caption: 'Grade',
	                    width: '5%',
	                    alignment: 'center',
	                    dataField: '_grade',
	                    validationRules: [{ type: 'required' }]
	                },
	                {
	                    caption: 'BirthDate',
	                    width: '10%',
	                    alignment: 'center',
	                    dataField: '_birthdate',
	                    dataType: 'date',
	                    validationRules: [{ type: 'required' }]
	                },
	                {
	                    caption: 'Address',
	                    width: '20%',
	                    alignment: 'left',
	                    dataField: '_address',
	                    validationRules: [{ type: 'required' }]
	                },
	                {
	                    caption: 'Note',
	                    width: '18%',
	                    alignment: 'left',
	                    dataField: '_note',
	                },
	                {
	                    caption: 'Detail',
	                    width: '10%',
	                    alignment: 'center',
	                    cellTemplate: function (container, options) {
	                        $("<div>").append($("<img>", {
	                            "class": "clsbtnCursor",
	                            "src": "https://i.ibb.co/hMHRSL7/file.png",
	                        })).on('dxclick', function () {
	                        	
	                        	var id = options.data._studentId;
	                        	var name = options.data._studentName;
	                        	
	                        	ShowPopUp(courseList, id, name);
	                        	
	                        }).appendTo(container);
	                    }
	                },
	                {
	                    caption: 'Edit',
	                    width: '5%',
	                    alignment: 'center',
	                    cellTemplate: function (container, cellInfo) {
	                        $("<div>").append($("<img>", {
	                            "class": "clsbtnCursor",
	                            "src": "https://i.ibb.co/Wzq5Nb9/edit.png",
	                        })).on('dxclick', function () {
	                            $('#studentsDatagrid').dxDataGrid('instance').editRow(cellInfo.rowIndex);
	                        }).appendTo(container);
	                    }
	                },
	                {
	                    caption: 'Delete',
	                    width: '5%',
	                    alignment: 'center',
	                    cellTemplate: function (container, options) {
	                        $("<div>").append($("<img>", {
	                            "class": "clsbtnCursor",
	                            "src": "https://i.ibb.co/HxkC20s/trash.png",
	                        })).on('dxclick', function () {
	                            $('#studentsDatagrid').dxDataGrid('instance').deleteRow(options.rowIndex);
	                        }).appendTo(container);
	                    }
	                },
	                
	            ], // Columns
	        }); //data grid
		  
		  
		  
		}); // loadCourse
	} // Init Extreme
	

	//------------------------------------------------------
	
	function ShowPopUp(courseList, id, name) {
		
		var courseData = courseList;
		
		// Get Score
		 $.ajax({
			    url: "CourseScoreServlet?id=" + id,
			    type: "GET",
			    dataType: "json",
			    success: function(courseScoreList) {
			    	
			    	dataCoureseScore = courseScoreList;
			    	console.log(dataCoureseScore);
			    	
			    	
			        var defer = $.Deferred();
			        if ($('#popupContainer').length <= 0) {
			            $("html").prepend('<div id="popupContainer"></div>');
			        }
			        const popup = $('#popupContainer').dxPopup({
			            contentTemplate: $('#content_template'),
			            showTitle: true,
			            titleTemplate: function(titleElement) {
			                titleElement.css("text-align", "center");
			                titleElement.text("Courses and scores of " + name);
			            },
			            width: 600,
			            height: 550,
			            visible: false,
			            hideOnOutsideClick: false,
			            toolbarItems: [{
			                widget: 'dxButton',
			                toolbar: 'bottom',
			                location: 'center',
			                options: {
			                    text: 'OK',
			                    onClick() {
			                    	var e = $("#popupContainer").dxPopup("instance");
			                        e.hide();
			                    },
			                },
			            }],
			            onShown: function (e) {
			                e.element.attr('act', 0);
			                $("#gridInPopup").dxDataGrid({

			                    dataSource: dataCoureseScore,
								
			                    keyExpr: '_courseId',
			                    editing: {
			                    	mode: 'form',
			                    	form: {
			                    		items: [
			                    			{
			                    				dataField: '_studentId',
			                    				label: {
			                    				    text: 'Student ID'
			                    				  },
			                    			},
			                    			{
			                    				dataField: '_courseId',
			                    				validationRules: [{type: 'required',}],
			                    			},
			                    			{
			                    				dataField: '_score',
			                    			}
			                    		],
			                    	},
			                    	allowAdding: true,
			                    },
			                    showBorders: true,
			                    showColumnLines: true,
			                    wordWrapEnabled: true,
			                    showRowLines: true,
			                    remoteOperations: {
			                        filtering: true,
			                        paging: true,
			                        sorting: false,
			                        groupPaging: false,
			                        grouping: false,
			                        summary: true
			                    },
			                    hoverStateEnabled: true,
			                    scrolling: { mode: 'virtual' },
			                    height: '100%',
			                    showColumnHeaders: true,

			    	            searchPanel: {
			    	            	visible: true,
			    	            },
			                    onInitNewRow: function(e) {
			    	            	e.component.columnOption('SIDCol', 'allowEditing', false);
			    	            	e.component.columnOption('CIDCol', 'allowEditing', true);
			    	            },
			    	            onEditingStart: function(e){
			    	            	e.component.columnOption('SIDCol', 'allowEditing', false);
			    	            	e.component.columnOption('CIDCol', 'allowEditing', false);
			    	            },
			    	            onRowRemoving: function(e) {
			    	            	var data = e.data;
			    	            	
			    	            	$.ajax({
			    	            		type: 'POST',
			    	            		url: 'CourseScoreServlet',
			    	            		data: {
			    	            			studentId: data._studentId,
			    	              	        courseId: data._courseId,
			    	              	        score: data._score,
			    	            			action: 'delete',
			    	            		},
			    	            		success: function(response) {
			    	            			const msg = 'Delete Success';
			    	            			DevExpress.ui.notify({
			    	            				message : msg,
			    	            				width: 300,
			    	            				position: {
			    	            					my: 'center top',
			    	            					at: 'center top',
			    	            				},
			    	            			}, 'success', 3000);
			    	            		},
			    	            		error: function(jqXHR, textStatus, errorThrown) {
			    	            			console.log(textStatus);
			    	            		}
			    	            	});
			    	            },
			    	            onRowInserting: function(e) {
			    	            	var data = e.data;
			    	            	var score = data._score;
			    	            	var newCourseId = e.data._courseId;

			    	            	if (score == null)
			    	            		{
			    	            			score = '0.0';
			    	            		}
			    	            
			    	                var joinedCourseIds = dataCoureseScore.map(function(item) {
			    	                    return item._courseId;
			    	                });
			    	                
			    	                var existingCourseIds = courseData.map(function(item) {
			    	                    return item._courseId;
			    	                });
			    	                
			    	                if(joinedCourseIds.includes(newCourseId)) {
			    	                    e.cancel = true;
			    	                    alert(name + " already join the Course " + newCourseId);
			    	                }
			    	                else {
			    	                	for (let i = 0; i < existingCourseIds.length; i++) {
			    	                		  if(existingCourseIds[i] == newCourseId){
			    	                			  $.ajax({
						    	                	    type: 'POST',
						    	                	    url: 'CourseScoreServlet',
						    	                	    data: {
						    	                	      studentId: id,
						    	                	      courseId: data._courseId,
						    	                	      score: score,
						    	                	      action: 'add'
						    	                	    },
						    	                	    success: function(response) {
						    	                	      console.log('post ok');
						    	                	      const msg = 'Add Success';
						    		            			DevExpress.ui.notify({
						    		            				message : msg,
						    		            				width: 300,
						    		            				position: {
						    		            					my: 'center top',
						    		            					at: 'center top',
						    		            				},
						    		            			}, 'success', 3000);
						    	                	    },
						    	                	    error: function(jqXHR, textStatus, errorThrown) {
						    	                	    	console.log(textStatus);
						    	                	    }
						    	                	  });
			    	                			  break;
			    	                		  } else {
			    	                			  if (i == existingCourseIds.length - 1){
				    	                			  e.cancel = true;
							    	                  alert("Course " + newCourseId + " not exist.");
			    	                			  }
			    	                		  }
			    	                		}
			    	                }
			    	            },
			    	            onRowUpdating: function(e) {
			    	            	var data = e.newData;
			    	            	var courseId = e.oldData._courseId;
			    		           	var score = data._score; 
			    	            	
			    		            // Check if the note field has been modified
			    		           // var isNoteModified = data.hasOwnProperty('_score') && data._score !== undefined;
			    		            
			    		            // Set the note variable based on the modified status
			    		           // var score = isNoteModified ? studentData._note : oldStudent._note || '';
			    	            	
			    	            	if (score === null || score === '')
			    	            		{
			    	            			score = '0.0';
			    	            		}
			    	            	
			    	            	$.ajax({
			    	            	    type: 'POST',
			    	            	    url: 'CourseScoreServlet',
			    	            	    data: {
			    	            	      studentId: id,
			    	            	      courseId: courseId,
			    	            	      score: score,
			    	            	      action: 'update'
			    	            	    },
			    	            	    success: function(response) {
			    	            	      console.log('post ok');
			    	            	      const msg = 'Update Success';
			  	            			DevExpress.ui.notify({
			  	            				message : msg,
			  	            				width: 300,
			  	            				position: {
			  	            					my: 'center top',
			  	            					at: 'center top',
			  	            				},
			  	            			}, 'success', 3000);
			    	            	    },
			    	            	    error: function(jqXHR, textStatus, errorThrown) {
			    	            	    	console.log(textStatus);
			    	            	    }
			    	            	  });
			    	            },
			                    columns: [
			                    	{
			                            caption: 'Student ID',
			                            dataField: '_studentId',
			                            name: 'SIDCol',
			                            visible: false,
			                        },
			                        {
			                            caption: 'Course ID',
	                    				name: 'CIDCol',
			                            dataField: '_courseId',
			                            width: '40%',
			                            alignment: 'center',
			                        },
			                        {
			                            caption: 'Score',
			                            dataField: '_score',
			                            width: '40%',
			                            alignment: 'center',
			                        },
			                        {
			    	                    caption: 'Edit',
			    	                    width: '10%',
			    	                    alignment: 'center',
			    	                    cellTemplate: function (container, cellInfo) {
			    	                        $("<div>").append($("<img>", {
			    	                            "class": "clsbtnCursor",
			    	                            "src": "https://i.ibb.co/Wzq5Nb9/edit.png",
			    	                        })).on('dxclick', function () {
			    	                            $('#gridInPopup').dxDataGrid('instance').editRow(cellInfo.rowIndex);
			    	                        }).appendTo(container);
			    	                    }
			    	                },
			    	                {
			    	                    caption: 'Delete',
			    	                    width: '10%',
			    	                    alignment: 'center',
			    	                    cellTemplate: function (container, options) {
			    	                        $("<div>").append($("<img>", {
			    	                            "class": "clsbtnCursor",
			    	                            "src": "https://i.ibb.co/HxkC20s/trash.png",
			    	                        })).on('dxclick', function () {
			    	                            $('#gridInPopup').dxDataGrid('instance').deleteRow(options.rowIndex);
			    	                        }).appendTo(container);
			    	                    }
			    	                },
			                    ],

			                });

			            },
			            onHidden: function (e) {
			                if (e.element.attr('act') == "1") {
			                    defer.resolve(true, $("#gridInPopup").dxDataGrid("instance").getSelectedRowsData());
			                }
			                else {
			                    defer.resolve(false, []);
			                }
			            },
			            animation: {
			                show: { type: "slide", from: { opacity: 1, top: -$(window).height() }, to: { top: 50 } },
			                hide: { type: "slide", from: { top: 50 }, to: { top: -$(window).height() } }
			            }
			        });

			        $("#popupContainer").dxPopup("instance").show();
			        return defer.promise();
			    },
			    error: function(xhr, textStatus, errorThrown) {
			      console.log(xhr.responseText);
			    }
			  }); // Ajax
	
    } // Showw PopUP
	
	
	//------------------------------------------
	$(document).ready(function(){
	})
	
	
	</script>
</body>
</html>