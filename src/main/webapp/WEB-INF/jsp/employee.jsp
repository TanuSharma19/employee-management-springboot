<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Form</title>
    <link rel="stylesheet" href="/css/employee.css">
</head>
<body>

<div class="container">
    <h2>Employee Application Form</h2>

    <form id="empForm">

        <label>Name <span class="required">*</span></label>
        <input type="text" id="name" required>

        <label>Email <span class="required">*</span></label>
        <input type="email" id="email" required>

        <label>Salary <span class="required">*</span></label>
        <input type="number" id="salary" required>

        <label>Gender</label>
        <div class="radio-group">
            <label><input type="radio" name="gender" value="Male"> Male</label>
            <label><input type="radio" name="gender" value="Female"> Female</label>
            <label><input type="radio" name="gender" value="Other"> Other</label>
        </div>

        <label>Department <span class="required">*</span></label>
        <select id="department" required>
            <option value="">-- Select --</option>
            <option value="IT">IT</option>
            <option value="HR">HR</option>
            <option value="Finance">Finance</option>
        </select>

        <label>Employment Type</label>
        <select id="employmentType">
            <option value="Permanent">Permanent</option>
            <option value="Contract">Contract</option>
        </select>

        <label>Skills</label>
        <div class="checkbox-group">
            <label><input type="checkbox" name="skills" value="Java"> Java</label>
            <label><input type="checkbox" name="skills" value="SQL"> SQL</label>
            <label><input type="checkbox" name="skills" value="Springboot"> Springboot</label>
            <label><input type="checkbox" name="skills" value="Hibernate"> Hibernate</label>
        </div>

        <label>Joining Date</label>
        <input type="date" id="joiningDate">

        <button type="submit">Save</button>

    </form>
</div>

<script>
/*UPDATE MODE – AUTOFILL*/
const params = new URLSearchParams(window.location.search);
const empId = params.get("id");

if (empId) {
    fetch("/api/employees/" + empId)
        .then(res => res.json())
        .then(emp => {

            document.getElementById("name").value = emp.name || "";
            document.getElementById("email").value = emp.email || "";
            document.getElementById("department").value = emp.department || "";
            document.getElementById("salary").value = emp.salary || "";
            document.getElementById("joiningDate").value = emp.joiningDate || "";

            // gender autofill
            if (emp.gender) {
                const g = document.querySelector(
                    'input[name="gender"][value="' + emp.gender + '"]'
                );
                if (g) g.checked = true;
            }

            // employment type autofill
            document.getElementById("employmentType").value = emp.employmentType || "";

            // skills autofill
            if (emp.skills) {
                emp.skills.split(",").forEach(skill => {
                    const cb = document.querySelector(
                        'input[name="skills"][value="' + skill.trim() + '"]'
                    );
                    if (cb) cb.checked = true;
                });
            }

            // mark form as UPDATE mode
            document.getElementById("empForm")
                    .setAttribute("data-edit-id", empId);
        });
}

/* SUBMIT – CREATE / UPDATE */
const form = document.getElementById("empForm");

form.addEventListener("submit", function(e) {
    e.preventDefault();

    const editId = form.getAttribute("data-edit-id");

    const genderEl = document.querySelector('input[name="gender"]:checked');
    const skillsArr = Array.from(
        document.querySelectorAll('input[name="skills"]:checked')
    ).map(cb => cb.value);

    const employeeData = {
        name: document.getElementById("name").value,
        email: document.getElementById("email").value,
        department: document.getElementById("department").value,
        salary: document.getElementById("salary").value,
        joiningDate: document.getElementById("joiningDate").value,

        gender: genderEl ? genderEl.value : null,
        employmentType: document.getElementById("employmentType").value,
        skills: skillsArr.join(",")
    };

    const url = editId
        ? "/api/employees/update/" + editId
        : "/api/employees/save";

    const method = editId ? "PUT" : "POST";

    fetch(url, {
        method: method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(employeeData)
    })
    .then(() => {
        window.location.href = "/employees";
    });
});
</script>

</body>
</html>
