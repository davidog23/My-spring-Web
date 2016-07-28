package net.davidog.repository;

import net.davidog.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.Optional;

/**
 * Created by David on 27/07/2016.
 */
@Transactional
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findOneByUsername(String username);
}
