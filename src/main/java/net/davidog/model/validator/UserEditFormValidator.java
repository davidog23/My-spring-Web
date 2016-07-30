package net.davidog.model.validator;

import net.davidog.model.User;
import net.davidog.model.UserEditForm;
import net.davidog.service.user.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.Optional;

/**
 * Created by David on 30/07/2016.
 */
@Component
public class UserEditFormValidator implements Validator{
    private static final Logger logger = LoggerFactory.getLogger(UserEditFormValidator.class);

    private final UserService userService;

    @Autowired
    public UserEditFormValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.equals(UserEditForm.class);
    }

    @Override
    public void validate(Object target, Errors errors) {
        UserEditForm form = (UserEditForm) target;
        validateUsername(errors, form);
    }

    private void validateUsername(Errors errors, UserEditForm form) {
        Optional<User> savedUser = userService.getUserByUsername(form.getUsername());
        if (savedUser.isPresent() && !savedUser.get().getId().equals(form.getId())) {
            errors.reject("username.exist", "This username already exists");
        }
    }
}
