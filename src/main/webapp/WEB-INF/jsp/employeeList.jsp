<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee List</title>
    <link rel="stylesheet" href="/css/employee.css">
</head>
<body>

<div class="container" style="width: 1200px;">
    <h2>Employee List</h2>

    <table border="1" width="100%" cellpadding="8" cellspacing="0">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Department</th>
                <th>Gender</th>
                <th>Type</th>
                <th>Skills</th>
                <th>Salary</th>
                <th>Joining Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="empTableBody">
			</tbody>
    </table>
    <a href="/employee-form">
    <button>Add Employee</button>
	</a>
</div>

<script>
fetch("/api/employees")
  .then(res => res.json())
  .then(data => {
      const tbody = document.getElementById("empTableBody");
      tbody.innerHTML = "";

      data.forEach(emp => {
          const row =
            "<tr>" +
              "<td>" + emp.id + "</td>" +
              "<td>" + emp.name + "</td>" +
              "<td>" + emp.email + "</td>" +
              "<td>" + emp.department + "</td>" +
              "<td>" + (emp.gender || "") + "</td>" +
              "<td>" + (emp.employmentType || "") + "</td>" +
              "<td>" + (emp.skills || "") + "</td>" +
              "<td>" + emp.salary + "</td>" +
              "<td>" + (emp.joiningDate || "") + "</td>" +
              "<td>" +
              "<button onclick='editEmployee(" + emp.id + ")'>Update</button>" +
              "<button onclick='deleteEmployee(" + emp.id + ")' class='delete-btn'>Delete</button>" +
            "</td>" +
            "</tr>";

          tbody.innerHTML += row;
      });
  });
  
function editEmployee(id) {
    // same form page reuse hoga (create + update)
    window.location.href = "/employee-form?id=" + id;
}

function deleteEmployee(id) {
    if (confirm("Are you sure you want to delete this employee?")) {
        fetch("/api/employees/delete/" + id, {
            method: "DELETE"
        })
        .then(() => {
            alert("Employee deleted");
            location.reload(); // list refresh
        });
    }
}
</script>

</body>
</html>
