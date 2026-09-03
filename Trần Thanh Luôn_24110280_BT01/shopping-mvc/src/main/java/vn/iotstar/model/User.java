package vn.iotstar.model;

import java.util.Date;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "[User]")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String email;

    private String username;

    private String fullname;

    private String password;

    private String avatar;

    private int roleid;

    private String phone;

    @Temporal(TemporalType.TIMESTAMP)
    private Date createddate;
}
