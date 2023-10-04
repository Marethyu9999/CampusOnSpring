package org.unidue.campusfm.queerzard.cms.database.services.user;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.unidue.campusfm.queerzard.cms.database.dao.UserEntity;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class UserDetails implements org.springframework.security.core.userdetails.UserDetails {

    @Getter private UserEntity userEntity;

    public UserDetails(UserEntity userEntity){
        this.userEntity = userEntity;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {

        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();

        this.userEntity.getPermissions().forEach(p -> {
            GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(p);
            grantedAuthorities.add(grantedAuthority);
        });

        this.userEntity.getRoles().forEach(r -> {
            GrantedAuthority grantedAuthority = new SimpleGrantedAuthority("ROLE_" + r);
            grantedAuthorities.add(grantedAuthority);
        });
        return grantedAuthorities;
    }

    @Override
    public String getPassword() {
        return userEntity.getPassword();
    }

    @Override
    public String getUsername() {
        return userEntity.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return userEntity.isEnabled();
    }


    //No Password Expiration here
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return userEntity.isEnabled();
    }
}
