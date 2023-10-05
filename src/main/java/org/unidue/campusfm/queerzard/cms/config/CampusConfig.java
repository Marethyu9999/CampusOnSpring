package org.unidue.campusfm.queerzard.cms.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.concurrent.TimeUnit;

@Configuration
public class CampusConfig implements WebMvcConfigurer {


    @Override
    public void addViewControllers(final ViewControllerRegistry registry) {
        registry.addViewController("/login");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/assets/")
                .setCacheControl(CacheControl.maxAge(30, TimeUnit.DAYS));
    }

}
