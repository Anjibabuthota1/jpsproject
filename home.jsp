<%@ page import="java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management System by Group 5</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h1 {
            text-align: center;
        }
        .container {
            width: 80%;
            margin: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"], input[type="email"], select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
        }
        input[type="submit"], input[type="reset"], input[type="button"] {
            padding: 10px 20px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <h1>STUDENT MANAGEMENT SYSTEM</h1>
    <div class="container">
        <form method="post" action="StudentManagement.jsp">
            <label for="studentName">Student Name:</label>
            <input type="text" id="studentName" name="studentName" required />

            <label for="studentID">Student ID:</label>
            <input type="text" id="studentID" name="studentID" required />

            <label for="studentGrade">Student Grade:</label>
            <input type="text" id="studentGrade" name="studentGrade" required />

            <label for="dob">Date of Birth:</label>
            <input type="text" id="dob" name="dob" required />

            <label>Gender:</label>
            <input type="radio" id="male" name="gender" value="Male" required />
            <label for="male">Male</label>
            <input type="radio" id="female" name="gender" value="Female" required />
            <label for="female">Female</label>

            <label for="contact">Contact Name:</label>
            <input type="text" id="contact" name="contact" required />

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required />

            <input type="submit" value="Add Student" />
            <input type="reset" value="Reset" />
        </form>

        <form method="post" action="StudentManagement.jsp">
            <label for="searchID">Search by Student ID:</label>
            <input type="text" id="searchID" name="searchID" />
            <input type="submit" value="Search" />
        </form>

        <table>
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Student ID</th>
                    <th>Grade</th>
                    <th>Date of Birth</th>
                    <th>Gender</th>
                    <th>Contact Name</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    HttpSession session = request.getSession();
                    List<Map<String, String>> students = (List<Map<String, String>>) session.getAttribute("students");
                    if (students == null) {
                        students = new ArrayList<>();
                    }

                    String studentName = request.getParameter("studentName");
                    String studentID = request.getParameter("studentID");
                    String studentGrade = request.getParameter("studentGrade");
                    String dob = request.getParameter("dob");
                    String gender = request.getParameter("gender");
                    String contact = request.getParameter("contact");
                    String email = request.getParameter("email");

                    if (studentName != null && studentID != null) {
                        Map<String, String> student = new HashMap<>();
                        student.put("studentName", studentName);
                        student.put("studentID", studentID);
                        student.put("studentGrade", studentGrade);
                        student.put("dob", dob);
                        student.put("gender", gender);
                        student.put("contact", contact);
                        student.put("email", email);
                        students.add(student);
                        session.setAttribute("students", students);
                    }

                    String searchID = request.getParameter("searchID");
                    for (Map<String, String> student : students) {
                        if (searchID == null || student.get("studentID").equals(searchID)) {
                %>
                <tr>
                    <td><%= student.get("studentName") %></td>
                    <td><%= student.get("studentID") %></td>
                    <td><%= student.get("studentGrade") %></td>
                    <td><%= student.get("dob") %></td>
                    <td><%= student.get("gender") %></td>
                    <td><%= student.get("contact") %></td>
                    <td><%= student.get("email") %></td>
                    <td>
                        <form method="post" action="StudentManagement.jsp">
                            <input type="hidden" name="deleteID" value="<%= student.get("studentID") %>" />
                            <input type="submit" value="Delete" />
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }

                    String deleteID = request.getParameter("deleteID");
                    if (deleteID != null) {
                        students.removeIf(s -> s.get("studentID").equals(deleteID));
                        session.setAttribute("students", students);
                        response.sendRedirect("StudentManagement.jsp");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
