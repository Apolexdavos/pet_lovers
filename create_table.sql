-- if you want to create database, the use the following command
-- CREATE DATABASE <database name>;
-- USE <database name>;

DROP TABLE IF EXISTS
    Action,
    Disease, Drugs, HealthRecord,
    Appointment,
    CareGiver, Service, Provider,
    ServiceType, ProviderType,
    Pet, Owner, ServiceRecord;

CREATE TABLE Owner
(
  owner_id VARCHAR(15) NOT NULL,
  username VARCHAR(25) NOT NULL,
  password VARCHAR(256) NOT NULL,
  YoB INT NOT NULL,
  Address VARCHAR(25) NOT NULL,
  Ward VARCHAR(25) NOT NULL,
  District VARCHAR(25) NOT NULL,
  City VARCHAR(25) NOT NULL,
  email VARCHAR(25) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  avatar DEFAULT "https://st.quantrimang.com/photos/image/072015/22/avatar.jpg"
  PRIMARY KEY (owner_id)
);

CREATE TABLE ProviderType
(
  type_id VARCHAR(15) NOT NULL,
  type_name VARCHAR(25) NOT NULL,
  PRIMARY KEY (type_id)
);

CREATE TABLE ServiceType
(
  type_id VARCHAR(15) NOT NULL,
  type_name VARCHAR(25) NOT NULL,
  general_category VARCHAR(25) NOT NULL,
  PRIMARY KEY (type_id)
);

CREATE TABLE Provider
(
  provide_id VARCHAR(15) NOT NULL,
  type_id VARCHAR(15) NOT NULL,
  provide_name VARCHAR(25) NOT NULL,
  email VARCHAR(25),
  phone VARCHAR(15) NOT NULL,
  website VARCHAR(25),
  address_nr_street VARCHAR(25) NOT NULL,
  ward VARCHAR(15) NOT NULL,
  district VARCHAR(15) NOT NULL,
  city VARCHAR(15) NOT NULL,
  facebook VARCHAR(25),
  CN1 VARCHAR(25),
  CN2 VARCHAR(25),
  PRIMARY KEY (provide_id),
  FOREIGN KEY (type_id) REFERENCES ProviderType(type_id),
  UNIQUE (provide_name),
  UNIQUE (email),
  UNIQUE (phone),
  UNIQUE (website),
  UNIQUE (facebook),
  UNIQUE (CN1),
  UNIQUE (CN2)
);

CREATE TABLE Service
(
  service_id VARCHAR(15) NOT NULL,
  service_name VARCHAR(25) NOT NULL,
  type_id VARCHAR(15) NOT NULL,
  PRIMARY KEY (service_id),
  FOREIGN KEY (type_id) REFERENCES ServiceType(type_id)
);

CREATE TABLE Appointment
(
  app_id VARCHAR(15) NOT NULL,
  app_date DATE NOT NULL,
  app_time TIME NOT NULL,
  provide_id VARCHAR(15) NOT NULL,
  service_id VARCHAR(15) NOT NULL,
  owner_id VARCHAR(15) NOT NULL,
  cost FLOAT NOT NULL,
  PRIMARY KEY (app_id, service_id, owner_id, provide_id),
  FOREIGN KEY (service_id) REFERENCES Service(service_id),
  FOREIGN KEY (owner_id) REFERENCES Owner(owner_id),
  FOREIGN KEY (provide_id) REFERENCES Provider(provide_id)
);

CREATE TABLE CareGiver
(
  cg_id VARCHAR(15) NOT NULL,
  cg_fname VARCHAR(25) NOT NULL,
  cg_lname VARCHAR(25) NOT NULL,
  provide_id VARCHAR(15) NOT NULL,
  PRIMARY KEY (cg_id),
  FOREIGN KEY (provide_id) REFERENCES Provider(provide_id)
);

CREATE TABLE Action
(
  app_id VARCHAR(15) NOT NULL,
  service_id VARCHAR(15) NOT NULL,
  cg_id VARCHAR(15) NOT NULL,
  PRIMARY KEY (app_id, service_id, cg_id),
  FOREIGN KEY (app_id) REFERENCES Appointment(app_id),
  FOREIGN KEY (service_id) REFERENCES Service(service_id),
  FOREIGN KEY (cg_id) REFERENCES CareGiver(cg_id)
);

CREATE TABLE Pet
(
  pet_id VARCHAR(15) NOT NULL,
  pet_name VARCHAR(25) NOT NULL,
  dob DATE,
  current_weight FLOAT NOT NULL,
  gender VARCHAR(5) NOT NULL,
  status VARCHAR(10),
  type VARCHAR(25),
  breed VARCHAR(25),
  microchip VARCHAR(25),
  rabbies_tag VARCHAR(25),
  image_dir DEFAULT "https://images-na.ssl-images-amazon.com/images/I/61PZW9WMvBL._AC_SL1500_.jpg",
  blood_type VARCHAR(5),
  reg_nr VARCHAR(25),
  reg_date DATE,
  insurance_id VARCHAR(25),
  owner_id VARCHAR(25),
  father_id VARCHAR(15),
  mother_id VARCHAR(15),
  PRIMARY KEY (pet_id),
  FOREIGN KEY (owner_id) REFERENCES Owner(owner_id),
  FOREIGN KEY (father_id) REFERENCES Pet(pet_id),
  FOREIGN KEY (mother_id) REFERENCES Pet(pet_id)
);

CREATE TABLE HealthRecord
(
  datetime VARCHAR(15) NOT NULL,
  record_id VARCHAR(15) NOT NULL,
  pet_id VARCHAR(15) NOT NULL,
  cg_id VARCHAR(15) NOT NULL,
  note VARCHAR(25),
  issue_id VARCHAR(25) NOT NULL,
  drug_id VARCHAR(25),
  PRIMARY KEY (record_id, cg_id, pet_id),
  FOREIGN KEY (drug_id) REFERENCES Drugs(drug_id),
  FOREIGN KEY (cg_id) REFERENCES CareGiver(cg_id),
  FOREIGN KEY (service_id) REFERENCES Service(service_id),
  FOREIGN KEY (pet_id) REFERENCES Pet(pet_id)
  FOREIGN KEY (issue_id) REFERENCES Issue(issue_id)
);
CREATE TABLE ServiceRecord
(
  datetime VARCHAR(15) NOT NULL,
  service_id VARCHAR(15) NOT NULL,
  provide_id VARCHAR(15) NOT NULL,
  cg_id VARCHAR(15),
  owner_id VARCHAR(15) NOT NULL,
  pet_id VARCHAR(15) NOT NULL,
  cost FLOAT NOT NULL,
  PRIMARY KEY (owner_id, provide_id, cg_id, service_id, pet_id),
  FOREIGN KEY (provide_id) REFERENCES Provider(provide_id)
  FOREIGN KEY (service_id) REFERENCES Service(service_id),
  FOREIGN KEY (owner_id) REFERENCES Owner(owner_id),
  FOREIGN KEY (cg_id) REFERENCES CareGiver(cg_id),
  FOREIGN KEY (pet_id) REFERENCES Pet(pet_id)
)


CREATE TABLE Drugs
(
  drug_id VARCHAR(15) NOT NULL,
  drug_name VARCHAR(25) NOT NULL,
  PRIMARY KEY (drug_id),
);

CREATE TABLE Issue
(
  issue_id VARCHAR(15) NOT NULL,
  issue_name VARCHAR(25) NOT NULL,
  PRIMARY KEY (issue_id),
);
