package com.example.ToDoApp.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ToDoApp.model.ToDo;
import com.example.ToDoApp.repo.IToDoRepo;

@Service
public class ToDoService {

    @Autowired
    IToDoRepo repo;

    public List<ToDo> getAllToDoItems() {
        ArrayList<ToDo> todoList = new ArrayList<>();
        repo.findAll().forEach(todoList::add);
        return todoList;
    }

    public ToDo getToDoItemById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public boolean updateStatus(Long id, String newStatus) {
        ToDo todo = getToDoItemById(id);
        if (todo != null) {
            todo.setStatus(newStatus);
            return saveOrUpdateToDoItem(todo);
        }
        return false;
    }

    public boolean saveOrUpdateToDoItem(ToDo todo) {
        ToDo updatedObj = repo.save(todo);
        return updatedObj != null;
    }

    public boolean deleteToDoItem(Long id) {
        if (repo.existsById(id)) {
            repo.deleteById(id);
            return !repo.existsById(id);
        }
        return false;
    }
}
