<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Add toDo item</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function validateForm() {
            var titleInput = document.getElementById("title").value.trim();
            if (titleInput === "") {
                Swal.fire({
                    icon: "error",
                    title: "Invalid Title",
                    text: "Title cannot be blank or contain only spaces."
                });
                return false; 
            }
            return true; 
        }

        window.onload = function() {
            // Set today's date as the minimum date
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
            var yyyy = today.getFullYear();
            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById("date").setAttribute("min", today);

            // Handle success/failure messages
            var msg = "${message}";
            console.log("Message received:", msg);
            if (msg === "Save Failure") {
                Swal.fire({
                    icon: "error",
                    title: "Oops...",
                    text: "Something went wrong!",
                    footer: '<a href="#">Why do I have this issue?</a>'
                });
            } else if (msg === "Save Success") {
                Swal.fire({
                    title: "Good job!",
                    text: "Your ToDo item has been saved successfully!",
                    icon: "success"
                });
            }
        }
    </script>
</head>
<body >
	
	
        
<div style="margin-left:450px; margin-top:100px;">

    <div class="container">
        <h1 class="p-3" style="margin-left:150px;margin-bottom:25px;">Add a todo Item</h1>

        <form:form action="/saveToDoItem" method="post" modelAttribute="todo" onsubmit="return validateForm();">
            <div class="row">
                <div class="form-group col-md-12" style="display:flex;">
                    <label class="col-md-3" for="title" style="margin-right:-200px;">Title</label>
                    <div class="col-md-6">
                        <form:input type="text" path="title" id="title"
                            class="form-control input-sm" required="required" aria-label="ToDo Title" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-md-12" style="display:flex;">
                    <label class="col-md-3" for="date" style="margin-right:-200px;">Date</label>
                    <div class="col-md-6">
                        <form:input type="date" path="date" id="date"
                            class="form-control input-sm" required="required" aria-label="ToDo Date" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-md-12" style="display:flex;">
                    <label class="col-md-3" for="status" style="margin-right:-200px;">Status</label>
                    <div class="col-md-6">
                        <form:select path="status" id="status" class="form-control input-sm">
                            <form:option value="Incomplete">Incomplete</form:option>
                        </form:select>
                    </div>
                </div>
            </div>

            <div class="row p-2">
			    <div class="col-md-12 d-flex ">
			        
			        <a href="/viewToDoList" class="btn btn-primary btn-custom" style="width:200px;margin:20px 20px 0px 100px;">
			            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
			                <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
			            </svg>  
			            Back
			        </a>
			        
			        <button type="submit" class="btn btn-success" style=" width:200px; margin-top:20px;">Save</button>
			        
			    </div>
			</div>

        </form:form>
    </div>
</div>
</body>
</html>
