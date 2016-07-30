package net.davidog.service.currentuser;

import net.davidog.model.CurrentUser;

/**
 * Created by David on 28/07/2016.
 */
public interface CurrentUserService {
    boolean canAccessUser(CurrentUser currentUser, Long id);
}
