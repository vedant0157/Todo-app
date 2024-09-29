<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Edit item</title>

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
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("date").setAttribute('min', today);

            var msg = "${message}";
            if (msg === "Edit Failure") {
                Swal.fire({
                    icon: "error",
                    title: "Oops...",
                    text: "Something went wrong with the edit."
                });
            } else if (msg === "Edit Success") {
                Swal.fire({
                    title: "Success!",
                    text: "Item edited successfully.",
                    icon: "success"
                });
            }
        };
    </script>
</head>
<body>
    
    <div style="margin-left:450px; margin-top:100px;">
        <div class="container">
            <h1 class="p-3" style="margin-left:220px;margin-bottom:25px;">Edit item</h1>

            <form:form action="/editSaveToDoItem" method="post" modelAttribute="todo" onsubmit="return validateForm();">
                <form:input path="id" type="hidden"/>
                <div class="row">
                    <div class="form-group col-md-12" style="display:flex;">
                        <label class="col-md-3" for="title" style="margin-right:-200px;;">Title</label>
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
                            <form:select path="status" id="status" class="form-control input-sm" aria-label="ToDo Status">
                                <form:option value="Incomplete">Incomplete</form:option>
                                <form:option value="Completed">Completed</form:option>
                                <form:option value="Pending">Pending</form:option>
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
