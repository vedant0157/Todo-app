package com.example.ToDoApp.model;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import javax.persistence.Column;  // Use javax.persistence
import javax.persistence.Entity;  // Use javax.persistence
import javax.persistence.GeneratedValue;  // Use javax.persistence
import javax.persistence.GenerationType;  // Use javax.persistence
import javax.persistence.Id;  // Use javax.persistence
import javax.persistence.Table;  // Use javax.persistence
import javax.validation.constraints.NotNull; // Updated import

@Entity
@Table(name = "todo")
public class ToDo {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @NotNull // Updated annotation
    private Long id;

    @Column
    @NotNull // Updated annotation
    private String title;

    @Column
    @NotNull // Updated annotation
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date;

    @Column
    @NotNull // Updated annotation
    private String status;

    public ToDo() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
