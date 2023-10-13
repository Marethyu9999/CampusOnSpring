package org.unidue.campusfm.queerzard.cms.database.dao;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.unidue.campusfm.queerzard.cms.utils.UtilitiesCollection;
import org.unidue.campusfm.queerzard.cms.utils.validators.DisallowedCharacters;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Entity
@Table(name = "user")
public class UserEntity extends AbstractEntity{

    @Getter @Setter @Column(unique = true, nullable = false)
    private String username;

    @Getter @Setter @Column(unique = true, nullable = false)
    private String email;

    @Getter @Setter
    private String firstName;

    @Getter @Setter
    private String lastName;

    @JsonIgnore
    @Getter private String password;

    @Getter @Setter
    private String social;
    @Getter @Setter private String position;


    @Column(columnDefinition = "LONGTEXT")
    @JsonIgnore @Getter
    private String base64Avatar;

    @Getter @Setter private boolean enabled;

    @Getter
    private long creationTimeStamp;
    @Getter
    private long lastLoginTimestamp;



    @OneToMany
    @JsonIgnore @Getter @Setter private List<ArticleEntity> articleEntities = new ArrayList<>();

   /* @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "users_roles",
            joinColumns = @JoinColumn(
                    name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "role_id", referencedColumnName = "id"))

    @Getter private List<Role> roles;*/
    @Getter private String roles;

    @Setter private String permissions;


    public UserEntity(String firstName, String lastName, String email, String password, String social,
                      String position, String avatar, String roles, String permissions, boolean enabled) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.username = email.split("@")[0];
        setPassword(password);
        this.social = social;
        this.position = position;
        this.base64Avatar = avatar;
        this.enabled = enabled;
        this.creationTimeStamp = System.currentTimeMillis();
        this.lastLoginTimestamp = 0L;
        this.roles = roles;
        this.permissions = permissions;
    }

    public UserEntity(String firstName, String lastName, String email, String password, String description,
                      String note, String roles, String permissions, boolean enabled) {
        this(firstName, lastName, email, password, description, note, UtilitiesCollection
                .toBase64(UtilitiesCollection.getFileBytes(UtilitiesCollection.getDefaultAvatarFile())), roles, permissions, enabled);

    }

    public UserEntity(String firstName, String lastName, String email, String password, String roles, String permissions, boolean enabled) {
        this(firstName, lastName, email, password, "Linkstgrünversiffte*r bei CampusFM",
                "Redakteur*in", roles, password, enabled);
    }

    public UserEntity() {}



    public void updateLastLogin() {
        this.lastLoginTimestamp = System.currentTimeMillis();
    }

    public void setPassword(String password){
        this.password = password;
    }

    public List<String> getPermissions(){
        if(this.permissions.length() > 0)
            return Arrays.asList(this.permissions.split(";"));
        return new ArrayList<>();
    }

    public List<String> getRoles(){
        if(this.roles.length() > 0)
            return Arrays.asList(this.roles.split(";"));
        return new ArrayList<>();
    }

}
