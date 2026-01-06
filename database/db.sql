CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);


CREATE TABLE families (
    id INT AUTO_INCREMENT PRIMARY KEY,
    family_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    family_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('male','female'),
    date_of_birth DATE,
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(150),
    baptism_status ENUM('baptized','not_baptized'),
    membership_status ENUM('active','inactive','transferred'),
    join_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES families(id)
);



CREATE TABLE ministries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    leader_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (leader_id) REFERENCES members(id)
);



CREATE TABLE ministry_members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ministry_id INT NOT NULL,
    member_id INT NOT NULL,
    joined_date DATE,
    FOREIGN KEY (ministry_id) REFERENCES ministries(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);


CREATE TABLE small_groups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    leader_id INT,
    meeting_location VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (leader_id) REFERENCES members(id)
);


CREATE TABLE small_group_members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    small_group_id INT,
    member_id INT,
    joined_date DATE,
    FOREIGN KEY (small_group_id) REFERENCES small_groups(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);


CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    service_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT,
    member_id INT,
    status ENUM('present','absent'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_id) REFERENCES services(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);


CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    description TEXT,
    event_date DATE,
    location VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE event_attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    member_id INT,
    status ENUM('present','absent'),
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);


CREATE TABLE contributions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    type ENUM('tithe','offering','donation','pledge'),
    amount DECIMAL(10,2),
    payment_method ENUM('cash','mpesa','bank'),
    reference VARCHAR(100),
    contribution_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(id)
);


CREATE TABLE announcements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    message TEXT,
    target ENUM('all','leaders','youth','members'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE prayer_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    request TEXT,
    is_confidential BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(id)
);


CREATE TABLE counseling_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    counselor_id INT,
    session_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (counselor_id) REFERENCES users(id)
);


CREATE TABLE assets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    condition_status ENUM('good','fair','damaged'),
    assigned_ministry INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assigned_ministry) REFERENCES ministries(id)
);


CREATE TABLE audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
