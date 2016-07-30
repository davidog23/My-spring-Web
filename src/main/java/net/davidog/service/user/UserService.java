package net.davidog.service.user;

import net.davidog.model.CurrentUser;
import net.davidog.model.User;
import net.davidog.model.UserCreateForm;
import net.davidog.model.UserEditForm;

import java.util.List;
import java.util.Optional;

/**
 * Created by David on 27/07/2016.
 */
public interface UserService {
    Optional<User> getUserById(long id);

    Optional<User> getUserByUsername(String username);

    List<User> getAllUsers();

    User create(UserCreateForm form);

    User update(UserEditForm form);
}
