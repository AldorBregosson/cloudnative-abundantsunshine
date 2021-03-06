package com.corneliadavis.cloudnative.connections;

import com.corneliadavis.cloudnative.Utils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;

@RestController
public class ConnectionsController {

    private static final Logger logger = LoggerFactory.getLogger(ConnectionsController.class);
    private UserRepository userRepository;
    private ConnectionRepository connectionRepository;
    
    @Value("${com.corneliadavis.cloudnative.connections.secret}")
    private String configuredSecret;
    
    @Autowired
    Utils utils;

    @Autowired
    public ConnectionsController(UserRepository userRepository, ConnectionRepository connectionRepository) {
        this.userRepository = userRepository;
        this.connectionRepository = connectionRepository;
    }

	@RequestMapping(method = RequestMethod.GET, value="/users")

	public Iterable<User> getUsers(HttpServletResponse response) {

        logger.info(utils.ipTag() + "getting users");
        Iterable<User> users;
        users = userRepository.findAll();

		return users;
	}

	@RequestMapping(method = RequestMethod.GET, value="/users/{user}")
	public User getByUsername(@PathVariable("user") String user, HttpServletResponse response) {
        String ipAddress = System.getenv("POD_IP");
        logger.info(utils.ipTag() + "getting user " + user);
        try {
            Long id = Long.parseLong(user);
            return userRepository.findById(id).get();
        } catch(NumberFormatException e) {
            return userRepository.findByUsername(user);
        }
    }

    @RequestMapping(method = RequestMethod.POST, value="/users")
    public void newUser(@RequestBody User newUser, HttpServletResponse response) {

        logger.info(utils.ipTag() + "Have a new user with username " + newUser.getUsername());
        userRepository.save(newUser);

    }

    @RequestMapping(method = RequestMethod.PUT, value="/users/{id}")
    public void updateUser(@PathVariable("id") Long userId, @RequestBody User newUser, HttpServletResponse response) {

        logger.info(utils.ipTag() + "Updating user with id " + userId);
        User user = userRepository.findById(userId).get();
        newUser.setId(userId);
        userRepository.save(newUser);

    }

    @RequestMapping(method = RequestMethod.GET, value="/connections")
    public Iterable<Connection> getConnections(HttpServletResponse response) {

        logger.info(utils.ipTag() + "getting connections");
        Iterable<Connection> connections;
        connections = connectionRepository.findAll();

        return connections;
    }

    @RequestMapping(method = RequestMethod.GET, value="/connections/{username}")
    public Iterable<Connection> getConnections(
        @PathVariable("username") String username,
        @RequestParam(value="secret", required=true) String secret,
        HttpServletResponse response) {
        logger.info(utils.ipTag() + "getting connections for username '" + username + "'");
        Long userId = getByUsername(username, null).getId();
        Iterable<Connection> connections;
    
        if (secret.equals(configuredSecret)) {
            // Never do this in productive apps (writing passwords to logs).
            logger.info(utils.ipTag() + "Accessing connections using secret '" + secret + "'");
            connections = connectionRepository.findByFollower(userId);
            return connections;
        } else {
            logger.warn(utils.ipTag() +
                "Attempt to access Connection service with secret '" + secret
                + "' (expecting '" + configuredSecret + "')");
            response.setStatus(401);
            return null;
        }
    }

    @RequestMapping(method = RequestMethod.POST, value="/connections")
    public void newConnection(@RequestBody Connection newConnection, HttpServletResponse response) {

        logger.info(utils.ipTag() + "Have a new connection: " + newConnection.getFollower() + " is following " + newConnection.getFollowed());
        connectionRepository.save(newConnection);

    }

    @RequestMapping(method = RequestMethod.DELETE, value="/connections/{id}")
    public void deleteConnection(@PathVariable("id") Long connectionId, HttpServletResponse response) {

        Connection connection = connectionRepository.findById(connectionId).get();

        logger.info(utils.ipTag() + "deleting connection: " + connection.getFollower() + " is no longer following " + connection.getFollowed());
        connectionRepository.delete(connection);
    }


}
