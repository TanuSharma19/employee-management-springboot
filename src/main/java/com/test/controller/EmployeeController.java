package com.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.test.model.Employee;
import com.test.service.EmployeeService;

@RestController
@RequestMapping("/api/employees")
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	@PostMapping("/save")
    public Employee saveEmployee(@RequestBody Employee employee) {
        return employeeService.saveEmployee(employee);
    }
	
	@GetMapping
    public List<Employee> getAllEmployees() {
        return employeeService.getAllEmployees();
    }
	
	@PutMapping("/update/{id}")
	public Employee updateEmployee(@PathVariable Long id,
	                               @RequestBody Employee employee) {
	    return employeeService.updateEmployee(id, employee);
	}
	
	@GetMapping("/{id}")
	public Employee getEmployeeById(@PathVariable Long id) {
	    return employeeService.getById(id);
	}
	
	@DeleteMapping("/delete/{id}")
	public void deleteEmployee(@PathVariable Long id)
	{
		employeeService.deleteEmployee(id);
	}

}
