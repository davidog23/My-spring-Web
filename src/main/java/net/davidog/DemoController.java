package net.davidog;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by David on 19/07/2016.
 */
@RestController
public class DemoController {
    private int id = 0;

    @RequestMapping(path = "/test")
    public String demo(@RequestParam(name = "name", required = false, defaultValue = "Jhonny") String name) {
        return "Hola " + name + ". Eres el número " + id++;
    }
}
