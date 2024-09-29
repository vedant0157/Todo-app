package com.example.ToDoApp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.ToDoApp.model.ToDo;
import com.example.ToDoApp.service.ToDoService;

import java.util.Map;

@Controller
public class ToDoController {

    @Autowired
    private ToDoService service;

    @GetMapping({"/", "viewToDoList"})
    public String viewAllToDoItems(Model model, @ModelAttribute("message") String message) {
        model.addAttribute("list", service.getAllToDoItems());
        model.addAttribute("message", message);
        return "ViewToDoList";
    }

    @PostMapping("/updateToDoStatus/{id}")
    public ResponseEntity<String> updateToDoStatus(@PathVariable Long id, @RequestBody Map<String, String> request) {
        String newStatus = request.get("status");
        if (service.updateStatus(id, newStatus)) {
            return ResponseEntity.ok("Status updated successfully");
        }
        return ResponseEntity.badRequest().body("Update failed");
    }

    @GetMapping("/addToDoItem")
    public String addToDoItem(Model model) {
        model.addAttribute("todo", new ToDo());
        return "AddToDoItem";
    }

    @PostMapping("/saveToDoItem")
    public String saveToDoItem(@ModelAttribute ToDo todo, RedirectAttributes redirectAttributes) {
        if (service.saveOrUpdateToDoItem(todo)) {
            redirectAttributes.addFlashAttribute("message", "Save Success");
            return "redirect:/viewToDoList";
        }
        redirectAttributes.addFlashAttribute("message", "Save Failure");
        return "redirect:/addToDoItem";
    }

    @GetMapping("/editToDoItem/{id}")
    public String editToDoItem(@PathVariable Long id, Model model) {
        model.addAttribute("todo", service.getToDoItemById(id));
        return "EditToDoItem";
    }

    @PostMapping("/editSaveToDoItem")
    public String editSaveToDoItem(@ModelAttribute ToDo todo, RedirectAttributes redirectAttributes) {
        if (service.saveOrUpdateToDoItem(todo)) {
            redirectAttributes.addFlashAttribute("message", "Edit Success");
            return "redirect:/viewToDoList";
        }
        redirectAttributes.addFlashAttribute("message", "Edit Failure");
        return "redirect:/editToDoItem/" + todo.getId();
    }

    @GetMapping("/deleteToDoItem/{id}")
    public String deleteToDoItem(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (service.deleteToDoItem(id)) {
            redirectAttributes.addFlashAttribute("message", "Delete Success");
            return "redirect:/viewToDoList";
        }
        redirectAttributes.addFlashAttribute("message", "Delete Failure");
        return "redirect:/viewToDoList";
    }
}
