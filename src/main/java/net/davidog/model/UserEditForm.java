package net.davidog.model;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

/**
 * Created by David on 29/07/2016.
 */
public class UserEditForm {
    @NotEmpty
    private String username;
    @NotNull
    private Long id;
    @NotNull
    private Role role;

    public UserEditForm() { username = ""; }

    public UserEditForm(User user) {
        username = user.getUsername();
        role = user.getRole();
        id = user.getId();
    }

    public String getUsername() {
        return username;
    }

    public Role getRole() {
        return role;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
