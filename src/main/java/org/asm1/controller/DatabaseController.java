package org.asm1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@RestController
public class DatabaseController {

    @Autowired
    private DataSource dataSource;

    @GetMapping("/check-db-connection")
    public String checkDbConnection() {
        try (Connection connection = dataSource.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT 1");
            if (resultSet.next()) {
                return "Database connection is successful!";
            } else {
                return "Failed to verify database connection.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Database connection failed: " + e.getMessage();
        }
    }
}
