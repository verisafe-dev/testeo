package com.japb.testeo.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/test")
public class TestController {

    @GetMapping
    public String hello() {
        return "¡Conexión exitosa! GET funcionando.";
    }

    @PostMapping
    public String echo(@RequestBody String body) {
        return "POST recibido: " + body;
    }
}
