package com.test.repositry;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.test.model.Employee;

@Repository
public interface EmployeeRepositry extends JpaRepository<Employee, Long> {

}
