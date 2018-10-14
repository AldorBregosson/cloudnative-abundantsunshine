package com.corneliadavis.cloudnative.connectionsposts.eventhandlers;

import com.corneliadavis.cloudnative.connectionsposts.localstorage.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by corneliadavis on 9/10/17.
 */

@RefreshScope
@RestController
@RequestMapping(value="/eventHandlers")
public class EventsController {

    private static final Logger logger = LoggerFactory.getLogger(EventsController.class);
    private MUserRepository userRepository;
    private MConnectionRepository connectionRepository;
    private MPostRepository postRepository;

    @Autowired
    public EventsController(MUserRepository userRepository,
                            MConnectionRepository connectionRepository,
                            MPostRepository postRepository) {
        this.userRepository = userRepository;
        this.connectionRepository = connectionRepository;
        this.postRepository = postRepository;
    }


    @RequestMapping(method = RequestMethod.POST, value="/users")
    public void newUser(@RequestBody com.corneliadavis.cloudnative.eventschemas.connections.User newUser, HttpServletResponse response) {

        logger.info("Creating new user in the cache with username " + newUser.getUsername());
        userRepository.save(new MUser(newUser.getId(), newUser.getName(), newUser.getUsername()));

    }

    @RequestMapping(method = RequestMethod.PUT, value="/users/{username}")
    public void updateUser(@PathVariable("username") String username, @RequestBody MUser newUser, HttpServletResponse response) {

        logger.info("Updating user cached in local storage with username " + username);
        MUser user = userRepository.findByUsername(username);
        newUser.setId(user.getId());
        userRepository.save(newUser);

    }

    @RequestMapping(method = RequestMethod.POST, value="/connections")
    public void newConnection(@RequestBody com.corneliadavis.cloudnative.eventschemas.connections.Connection newConnection, HttpServletResponse response) {

        logger.info("Have a new connection in the cache: " + newConnection.getFollower() +
                    " is following " + newConnection.getFollowed());
        MConnection connection = new MConnection(newConnection.getId(), newConnection.getFollower(),
                                                  newConnection.getFollowed());
        // add connection to the users
        MUser user;
        user = userRepository.findOne(newConnection.getFollower());
        connection.setFollowerUser(user);
        user = userRepository.findOne(newConnection.getFollowed());
        connection.setFollowedUser(user);
        connectionRepository.save(connection);
    }

    @RequestMapping(method = RequestMethod.DELETE, value="/connections/{follower}/{followed}")
    public void deleteConnection(@PathVariable("follower") String followerUsername,
                                 @PathVariable("followed") String followedUsername, HttpServletResponse response) {



        logger.info("deleting from the cache connection: " + followerUsername +
                " is no longer following " + followedUsername);
        MUser follower = userRepository.findByUsername(followerUsername);
        MUser followed = userRepository.findByUsername(followedUsername);
        MConnection connection = connectionRepository.findByFollowerUserAndFollowedUser(follower,followed);
        if (connection == null)
            logger.info("unable to find or delete that connection");
        else
            connectionRepository.delete(connection);

    }

    @RequestMapping(method = RequestMethod.POST, value="/posts")
    public void newPost(@RequestBody com.corneliadavis.cloudnative.eventschemas.posts.Post newPost, HttpServletResponse response) {

        logger.info("Have a new post in the cache with title " + newPost.getTitle());
        MPost post = new MPost(newPost.getId(), newPost.getDate(), newPost.getUserId(), newPost.getTitle());
        MUser user;
        user = userRepository.findOne(newPost.getUserId());
        post.setmUser(user);
        postRepository.save(post);

    }

}