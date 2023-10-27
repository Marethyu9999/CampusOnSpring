package org.unidue.campusfm.queerzard.cms.web.controllers.admin.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.unidue.campusfm.queerzard.cms.database.services.interfaces.UserService;

import javax.naming.AuthenticationException;
import java.security.Principal;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String getLogin(Principal principal){
        if(principal != null)
            return "redirect:myprofile";
        return "security/login";
    }

}
