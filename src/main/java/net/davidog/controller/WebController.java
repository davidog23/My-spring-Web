package net.davidog.controller;

import net.davidog.model.CurrentUser;
import net.davidog.model.UserCreateForm;
import net.davidog.model.validator.UserCreateFormValidator;
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

    @Autowired
    public WebController(UserService userService, UserCreateFormValidator userCreateFormValidator) {
        this.userService = userService;
        this.userCreateFormValidator = userCreateFormValidator;
    }

    @InitBinder("form")
    public void initBinder(WebDataBinder binder) {
        binder.addValidators(userCreateFormValidator);
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

    @PreAuthorize("@currentUserServiceImpl.canAccessUser(#currentUser.user, #username)")
    @RequestMapping("/user/{username}")
    public ModelAndView getUserPage(@PathVariable String username, @AuthenticationPrincipal CurrentUser currentUser) {
        return new ModelAndView("user", "user", userService.getUserByUsername(username)
                .orElseThrow(() -> new NoSuchElementException(String.format("User=%s not found", username))));
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping(value = "/user/create", method = RequestMethod.GET)
    public ModelAndView getUserCreatePage() {
        return new ModelAndView("user_create", "form", new UserCreateForm());
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping(value = "/user/create", method = RequestMethod.POST)
    public String handleUserCreateForm(@Valid @ModelAttribute("form") UserCreateForm form, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "user_create";
        }
        try {
            userService.create(form);
        } catch (DataIntegrityViolationException e) {
            bindingResult.reject("username.exists", "Username already exists");
            return "user_create";
        }
        logger.info("Created user: " + form.getUsername() + " as " + form.getRole().toString());
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
