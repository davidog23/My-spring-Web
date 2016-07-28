package net.davidog.service.currentuser;

import net.davidog.model.CurrentUser;
import net.davidog.model.Role;
import org.springframework.stereotype.Service;

/**
 * Created by David on 28/07/2016.
 */

@Service
public class CurrentUserServiceImpl implements CurrentUserService {
    @Override
    public boolean canAccessUser(CurrentUser currentUser, String username) {
        return currentUser != null
                && (currentUser.getRole() == Role.ADMIN || currentUser.getUsername().equals(username));
    }
}
