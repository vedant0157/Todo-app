<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>View todo item list</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #f4f7fa;
        }
        h1 {
            font-family: monospace;
            text-align: center;
            margin: 20px 0;
        }
        .btn-custom {
            font-size: 16px;
            width: 200px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            text-align: left;
            padding: 16px;
        }
        tr:nth-child(even) {
            background-color: #e9f7ef;
        }
        tr:hover {
            background-color: #d1e7dd;
        }
        .btn-table {
            padding: 5px 10px;
            margin: 2px;
        }
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
    </style>
</head>
<body>

    <div class="container-fluid">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <h1 style="margin-left:50px;">Todo item list</h1>
            <a href="/addToDoItem" class="btn btn-primary btn-custom" style="margin-right:50px;">Add new todo item</a>
        </div>

        <form:form>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Title</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th style="width:250px;">Mark completed</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="todo" items="${list}">
                            <tr>
                                <td>${todo.id}</td>
                                <td>${todo.title}</td>
                                <td>
                                    <fmt:formatDate value="${todo.date}" pattern="yyyy-MM-dd" />
                                </td>
                                <td class="status-cell">${todo.status}</td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="javascript:void(0);" 
                                           onclick="toggleStatus(${todo.id}, '${todo.status}', this);" 
                                           class="btn btn-table ${todo.status == 'Completed' ? 'btn-info' : 'btn-success'}">
                                            <span class="button-text">${todo.status == 'Completed' ? 'Mark incomplete' : 'Mark complete'}</span>
                                        </a>
                                    </div>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="/editToDoItem/${todo.id}" class="btn btn-primary btn-table">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                    </div>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="/deleteToDoItem/${todo.id}" class="btn btn-danger btn-table">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </form:form>
    </div>

    <script>
        function toggleStatus(todoId, currentStatus, buttonElement) {
            var newStatus = currentStatus === 'Completed' ? 'Incomplete' : 'Completed';
            var newClass = newStatus === 'Completed' ? 'btn-info' : 'btn-success'; // btn-success for completed, btn-info for incomplete

            // Send the AJAX request
            $.ajax({
                url: '/updateToDoStatus/' + todoId,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ status: newStatus }),
                success: function(response) {
                    // Update the button appearance immediately
                    $(buttonElement).find('.button-text').text(newStatus === 'Completed' ? 'Mark incomplete' : 'Mark complete');
                    $(buttonElement).removeClass('btn-info btn-success').addClass(newClass);
                    $(buttonElement).closest('tr').find('.status-cell').text(newStatus);

                    Swal.fire({
                        title: "Success!",
                        text: `Todo item marked as ${newStatus}.`,
                        icon: "success"
                    });
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Error updating status:", textStatus, errorThrown);
                    Swal.fire({
                        title: "Error!",
                        text: "Could not update the status. Please try again.",
                        icon: "error"
                    });

                    // Revert button appearance if the update fails
                    $(buttonElement).find('.button-text').text(currentStatus === 'Completed' ? 'Mark complete' : 'Mark incomplete');
                    $(buttonElement).removeClass(newClass).addClass(currentStatus === 'Completed' ? 'btn-success' : 'btn-info');
                    $(buttonElement).closest('tr').find('.status-cell').text(currentStatus);
                }
            });
        }

        window.onload = function() {
            var msg = "${message}";
            if (msg === "Save success") {
                Swal.fire({
                    title: "Success!",
                    text: "Item added successfully!",
                    icon: "success"
                });
            } else if (msg === "Delete success") {
                Swal.fire({
                    title: "Deleted!",
                    text: "Item deleted successfully!",
                    icon: "success"
                });
            } else if (msg === "Delete failure") {
                Swal.fire({
                    title: "Error!",
                    text: "Some error occurred, couldn't delete item",
                    icon: "error"
                });
            } else if (msg === "Edit success") {
                Swal.fire({
                    title: "Updated!",
                    text: "Item updated successfully!",
                    icon: "success"
                });
            }
        }
    </script>

</body>
</html>
