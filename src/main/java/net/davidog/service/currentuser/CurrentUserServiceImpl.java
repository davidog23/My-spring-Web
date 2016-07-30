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
    public boolean canAccessUser(CurrentUser currentUser, Long id) {
        return currentUser != null
                && (currentUser.getRole() == Role.ADMIN || currentUser.getRole() == Role.SAMPLE || currentUser.getId().equals(id));
    }

    @Override
    public boolean canEditUser(CurrentUser currentUser, Long id) {
        return currentUser != null
                && (currentUser.getRole() == Role.ADMIN || currentUser.getId().equals(id));
    }
}
