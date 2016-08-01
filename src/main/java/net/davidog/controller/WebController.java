package net.davidog.controller;

import net.davidog.model.CurrentUser;
import net.davidog.model.Role;
import net.davidog.model.UserCreateForm;
import net.davidog.model.UserEditForm;
import net.davidog.model.validator.UserCreateFormValidator;
import net.davidog.model.validator.UserEditFormValidator;
import net.davidog.service.user.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.NoSuchElementException;
import java.util.Optional;

/**
 * Created by David on 27/07/2016.
 */
@Controller
public class WebController {
    private static final Logger logger = LoggerFactory.getLogger(WebController.class);

    private final UserService userService;
    private final UserCreateFormValidator userCreateFormValidator;
    private final UserEditFormValidator userEditFormValidator;

    @Autowired
    public WebController(UserService userService, UserCreateFormValidator userCreateFormValidator, UserEditFormValidator userEditFormValidator) {
        this.userService = userService;
        this.userCreateFormValidator = userCreateFormValidator;
        this.userEditFormValidator = userEditFormValidator;
    }

    @InitBinder("createForm")
    public void initBinderCreate(WebDataBinder binder) {
        binder.addValidators(userCreateFormValidator);
    }

    @InitBinder("editForm")
    public void initBinderEdit(WebDataBinder binder) {
        binder.addValidators(userEditFormValidator);
    }

    @RequestMapping("/")
    public ModelAndView getHomePage() {
        return new ModelAndView("home");
    }

    /**
     * The method authorized to all users
     * @return The object representing the DOM
     */
    @RequestMapping("/users")
    public ModelAndView getUsersPage() {
        return new ModelAndView("users", "users", userService.getAllUsers());
    }

    @PreAuthorize("@currentUserServiceImpl.canAccessUser(#currentUser.user, #id)")
    @RequestMapping("/user/{id}")
    public ModelAndView getUserPage(@PathVariable Long id, @AuthenticationPrincipal CurrentUser currentUser) {
        return new ModelAndView("user", "user", userService.getUserById(id)
                .orElseThrow(() -> new NoSuchElementException(String.format("User=%s not found", id))));
    }

    @PreAuthorize("@currentUserServiceImpl.canAccessUser(#currentUser.user, #id)")
    @RequestMapping(value = "/user/{id}/edit", method = RequestMethod.GET)
    public ModelAndView getUserEditPage(@PathVariable Long id, @AuthenticationPrincipal CurrentUser currentUser) {
        return new ModelAndView("user_edit", "editForm", new UserEditForm(userService.getUserById(id)
                .orElseThrow(() -> new NoSuchElementException(String.format("User=%s not found", id)))));
    }

    @PreAuthorize("@currentUserServiceImpl.canEditUser(#currentUser.user, #id)")
    @RequestMapping(value = "/user/{id}/edit", method = RequestMethod.POST)
    public String handleUserEditForm(@Valid @ModelAttribute("editForm") UserEditForm editForm, @PathVariable Long id, @AuthenticationPrincipal CurrentUser currentUser, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "user_edit";
        }
        try {
            editForm.setId(id);
            if (!currentUser.getRole().equals(Role.ADMIN)) editForm.setRole(currentUser.getRole());
            userService.update(editForm);
        } catch (DataIntegrityViolationException e) {
            bindingResult.reject("username.exists", "Username already exists");
            return "user_edit";
        }
        logger.info("Updated user number: " + editForm.getId() + " to username: " + editForm.getUsername() + " as " + editForm.getRole().toString());
        return currentUser.getRole().equals(Role.ADMIN) ? "redirect:/users" : "redirect:/user/" + id;
    }

    @PreAuthorize("@currentUserServiceImpl.canAccessUser(#currentUser.user, -1)")
    @RequestMapping(value = "/user/create", method = RequestMethod.GET)
    public ModelAndView getUserCreatePage(@AuthenticationPrincipal CurrentUser currentUser) {
        return new ModelAndView("user_create", "createForm", new UserCreateForm());
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping(value = "/user/create", method = RequestMethod.POST)
    public String handleUserCreateForm(@Valid @ModelAttribute("createForm") UserCreateForm createForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "user_create";
        }
        try {
            userService.create(createForm);
        } catch (DataIntegrityViolationException e) {
            bindingResult.reject("username.exists", "Username already exists");
            return "user_create";
        }
        logger.info("Created user: " + createForm.getUsername() + " as " + createForm.getRole().toString());
        return "redirect:/users";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView getLoginPage(@RequestParam Optional<String> error) {
        logger.debug("Getting login page, error={}", error);
        return new ModelAndView("login", "error", error);
    }

    @RequestMapping(value = "/403")
    public ModelAndView getAccessDeniedPage() {
        return new ModelAndView("403");
    }
}
