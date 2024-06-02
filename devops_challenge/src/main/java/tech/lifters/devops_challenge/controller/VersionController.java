package tech.lifters.devops_challenge.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tech.lifters.devops_challenge.controller.dto.VersionDTO;

@RestController
@RequestMapping("/version")
public class VersionController {
    @GetMapping
    public VersionDTO version(){
        return new VersionDTO("V1.0.0");
    }
}
