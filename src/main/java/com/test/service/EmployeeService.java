package com.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.model.Employee;
import com.test.repositry.EmployeeRepositry;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeRepositry employeeRepositry;
	
	public Employee saveEmployee(Employee employee) {
		return employeeRepositry.save(employee);
	}
	
	public List<Employee> getAllEmployees()
	{
		return employeeRepositry.findAll();
	}
	
	public Employee updateEmployee(Long id, Employee updatedEmployee) {

        Employee existing = employeeRepositry.findById(id)
                .orElseThrow(() -> new RuntimeException("Employee not found"));

        existing.setName(updatedEmployee.getName());
        existing.setEmail(updatedEmployee.getEmail());
        existing.setDepartment(updatedEmployee.getDepartment());
        existing.setSalary(updatedEmployee.getSalary());
        existing.setGender(updatedEmployee.getGender());
        existing.setEmploymentType(updatedEmployee.getEmploymentType());
        existing.setSkills(updatedEmployee.getSkills());
        existing.setJoiningDate(updatedEmployee.getJoiningDate());

        return employeeRepositry.save(existing);
    }
	
	public Employee getById(Long id) {
	    return employeeRepositry.findById(id)
	            .orElseThrow(() -> new RuntimeException("Employee not found"));
	}
	
	public void deleteEmployee(Long id)
	{
		employeeRepositry.deleteById(id);
	}

}
