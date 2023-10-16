

# ---------------------------------------------------------------------- #
# DBMS:                  MYSQL 8                                         #
# LAB1 name:             LINKEDIN JOB POSTING ANALYSIS                   #
# Author:                GROUP 2                                         #
#                                                                        #
# ---------------------------------------------------------------------- #

DROP TABLE IF EXISTS `JOB`;
CREATE TABLE `JOB` (
    `job_id` BIGINT(100) NOT NULL,
    `company_id` BIGINT(100) NOT NULL,
    `job_title`  VARCHAR(500),
    `max_salary` DECIMAL(12,2),
    `min_salary` DECIMAL(12,2),
    `pay_period` VARCHAR(100),
	`formatted_work_type` VARCHAR(100),
    `location` VARCHAR(1000),
	`formatted_experience_level` VARCHAR(100),
    `sponsored` VARCHAR(100),
    `work_type` VARCHAR(100),
    CONSTRAINT `PK_JOB` PRIMARY KEY (`job_id`,`company_id`)
);

CREATE INDEX `job_index` ON `JOB` (`job_id`,`company_id`);
-- CREATE INDEX `company_id` ON `JOB` (`company_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "JOB"                         #
# ---------------------------------------------------------------------- #
INSERT INTO JOB(job_id, company_id, job_title, max_salary, min_salary, pay_period, formatted_work_type, location, formatted_experience_level, sponsored, work_type)
SELECT job_id,company_id,title,max_salary,min_salary,pay_period,formatted_work_type, location, formatted_experience_level, sponsored, work_type
FROM `job_postings`;


# ---------------------------------------------------------------------- #
# CREATE TABLE "JOB_POST"                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `JOBPOST`;
CREATE TABLE `JOBPOST` (
    `job_id`  BIGINT(100) NOT NULL,
	`company_id` BIGINT(100) NOT NULL,
    `applies` INT(12),
    `views` INT(12),
    `job_posting_url` VARCHAR(500),
    `application_url` VARCHAR(1000),
    `application_type` VARCHAR(500),
	`posting_domain` VARCHAR(500),
    
    CONSTRAINT `PK_JOB` PRIMARY KEY (`job_id`)
);

CREATE INDEX `JOB_POST_index` ON `JOBPOST` (`company_id`,`job_id`);

# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "JOBPOST"                     #
# ---------------------------------------------------------------------- #
INSERT INTO JOBPOST(job_id,company_id,views, job_posting_url,application_url,application_type,posting_domain)
SELECT job_id,company_id,views,job_posting_url,application_url,application_type,posting_domain
FROM `job_postings`;


# ---------------------------------------------------------------------- #
# CREATE TABLE "BENEFIT".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `BENEFIT`;
CREATE TABLE `BENEFIT` (
    `job_id` BIGINT(100) NOT NULL,
    `type` VARCHAR(100)
);
CREATE INDEX `BENEFIT_index` ON `BENEFIT` (`job_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "BENEFIT"                     #
# ---------------------------------------------------------------------- #
INSERT INTO BENEFIT(`job_id`,`type`)
SELECT `job_id`,`type`
FROM `benefits`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "JOBSKILL".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `JOBSKILL`;
CREATE TABLE `JOBSKILL` (
    `job_id` BIGINT(12) NOT NULL,
    `skill` VARCHAR(255)
);
CREATE INDEX `JOBSKILL_index` ON `JOBSKILL` (`job_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "JOBSKILL"                     #
# ---------------------------------------------------------------------- #
INSERT INTO JOBSKILL(`job_id`,`skill`)
SELECT `job_id`,`skill_abr`
FROM `job_skills`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "COMPANY".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `COMPANY`;
CREATE TABLE `COMPANY` (
    `company_id` BIGINT(100) NOT NULL,
    `name` VARCHAR(500),
    `state` VARCHAR(500),
    `city` VARCHAR(500),
    `country` VARCHAR(500),
    `company_url`  VARCHAR(500),
    CONSTRAINT `PK_COMPANY` PRIMARY KEY (`company_id`)
);
CREATE INDEX `COMPANY_Index` ON `COMPANY` (`company_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "COMPANY"                     #
# ---------------------------------------------------------------------- #
INSERT INTO COMPANY(`company_id`,`name`,`state`,`city`,`country`,`company_url`)
SELECT `company_id`,`name`,`state`,`city`,`country`,`url`
FROM `companies`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "EMP_CNT".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `EMP_CNT`;
CREATE TABLE `EMP_CNT` (
    `company_id` BIGINT(12) NOT NULL,
    `employee_count` BIGINT(12),
    `follower_count` BIGINT(12),
CONSTRAINT `PK_COMPANY` PRIMARY KEY (`company_id`)
);
CREATE INDEX `EMP_CNT_INDEX` ON `EMP_CNT` (`company_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "EMP_CNT"                     #
# ---------------------------------------------------------------------- #
INSERT INTO `EMP_CNT`(`company_id`,`employee_count`,`follower_count`)
SELECT `company_id`,`employee_count`,`follower_count`
FROM `employee_counts`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "COMP_INDUSTRY".                                           #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `COMP_INDUSTRY`;
CREATE TABLE `COMP_INDUSTRY` (
    `company_id` BIGINT(12) NOT NULL,
    `industry` VARCHAR(255)
);
CREATE INDEX `COMP_INDUSTRY` ON `COMP_INDUSTRY` (`company_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "COMP_INDUSTRY"               #
# ---------------------------------------------------------------------- #
INSERT INTO COMP_INDUSTRY(`company_id`,`industry`)
SELECT `company_id`,`industry`
FROM `p_company_industries`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "COMP_SPCLTY".                                           #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `COMP_SPCLTY`;
CREATE TABLE `COMP_SPCLTY` (
    `company_id` BIGINT(100) NOT NULL,
    `speciality` VARCHAR(5000)
);
CREATE INDEX `COMP_SPCLTY` ON `COMP_SPCLTY` (`company_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "COMP_SPCLTY"                 #
# ---------------------------------------------------------------------- #
INSERT INTO COMP_SPCLTY(`company_id`,`speciality`)
SELECT `company_id`,`speciality`
FROM `company_specialities`;


# ---------------------------------------------------------------------- #
# Foreign key constraints                                                #
# ---------------------------------------------------------------------- #

SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE `JOB` ADD CONSTRAINT `fk_JOB_COMPANY`
    FOREIGN KEY (`company_id`)
    REFERENCES `COMPANY` (`company_id`);
    
ALTER TABLE `BENEFIT` ADD CONSTRAINT `fk_BENEFIT_JOB1`
    FOREIGN KEY (`job_id`)
    REFERENCES `JOB` (`job_id`);
    
ALTER TABLE `COMP_INDUSTRY` ADD CONSTRAINT `fk_COMP_INDUSTRY_COMPANY1`
    FOREIGN KEY (`company_id`)
    REFERENCES `COMPANY` (`company_id`);
    
 ALTER TABLE `COMP_SPCLTY` ADD CONSTRAINT `fk_COMP_SPCLTY_COMPANY1`
    FOREIGN KEY (`company_id`)
    REFERENCES `COMPANY` (`company_id`);
    
ALTER TABLE `EMP_CNT` ADD  CONSTRAINT `fk_EMP_CNT_COMPANY1`
    FOREIGN KEY (`company_id`)
    REFERENCES `COMPANY` (`company_id`);
    
ALTER TABLE `JOBPOST` ADD  CONSTRAINT `fk_JOBPOST_JOB1`
    FOREIGN KEY (`job_id` , `company_id`)
    REFERENCES `JOB` (`job_id` , `company_id`);
    
ALTER TABLE `JOBSKILL` ADD  CONSTRAINT `fk_JOBSKILL_JOB1`
    FOREIGN KEY (`job_id`)
    REFERENCES `JOB` (`job_id`);

# ---------------------------------------------------------------------- #
# TRIGGERS                                                               #
# ---------------------------------------------------------------------- #

CREATE TABLE archive_table LIKE JOBPOST;

DELIMITER //
CREATE TRIGGER archive_job_trigger 
BEFORE UPDATE ON JOBPOST
FOR EACH ROW 
BEGIN
  IF NEW.applies >= 200 THEN
    INSERT INTO archive_table SELECT * FROM job_postings WHERE job_id = NEW.job_id;
    DELETE FROM job_postings WHERE job_id = NEW.job_id;
  END IF;
END;
//
DELIMITER ;

# ---------------------------------------------------------------------- #
# TRIGGERS WITH NOTIFICATION AND LOGGING                                 #
# ---------------------------------------------------------------------- #


-- Logging Table
CREATE TABLE trigger_logs (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  job_id INT,
  event VARCHAR(255),
  event_time TIMESTAMP
);

-- Notification Table
CREATE TABLE notifications (
  notification_id INT AUTO_INCREMENT PRIMARY KEY,
  job_id INT,
  message TEXT,
  notification_time TIMESTAMP
);


DELIMITER //
CREATE TRIGGER archive_job_trigger 
BEFORE UPDATE ON JOBPOST
FOR EACH ROW 
BEGIN
  IF NEW.applies >= 200 THEN
  
    -- Insert into Log Table
    INSERT INTO trigger_logs (job_id, event, event_time) VALUES (NEW.job_id, 'Archived', NOW());
    
    -- Insert into Notification Table
    INSERT INTO notifications (job_id, message, notification_time) VALUES (NEW.job_id, 'Job has been archived.', NOW());
  
    -- Insert the record into the archive table
    INSERT INTO archive_table SELECT * FROM job_postings WHERE job_id = NEW.job_id;
    
    -- Delete the record from the main table
    DELETE FROM JOBPOST WHERE job_id = NEW.job_id;
  END IF;
END;
//
DELIMITER ;


# ---------------------------------------------------------------------- #
# TRIGGERS FOR EXPIRE JOBS                                               #
# ---------------------------------------------------------------------- #

DELIMITER //
CREATE TRIGGER expire_job_trigger 
BEFORE UPDATE ON JOBPOST                    
FOR EACH ROW                               
BEGIN
  IF DATEDIFF(NOW(), NEW.post_date) > 30 THEN   
    INSERT INTO archive_table SELECT * FROM JOBPOST WHERE job_id = NEW.job_id;  
    DELETE FROM JOBPOST WHERE job_id = NEW.job_id;                             
  END IF;
END;
//
DELIMITER ;

# ---------------------------------------------------------------------- #
# TRIGGERS FOR LOW INTEREST JOBS                                         #
# ---------------------------------------------------------------------- #

CREATE TABLE low_interest_jobs_table LIKE JOBPOST;

DELIMITER //
CREATE TRIGGER low_interest_jobs 
BEFORE UPDATE ON JOBPOST                   
FOR EACH ROW                              
BEGIN
  IF NEW.applies <= 5 AND DATEDIFF(NOW(), NEW.post_date) > 10 THEN  
    INSERT INTO low_interest_jobs_table SELECT * FROM JOBPOST WHERE job_id = NEW.job_id; 
    DELETE FROM JOBPOST WHERE job_id = NEW.job_id;                                       
  END IF;
END;
//
DELIMITER ;


# ---------------------------------------------------------------------- #
# CREATING SALARY CHANGE TABLE                                          #
# ---------------------------------------------------------------------- #

CREATE TABLE salary_change_logs (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  job_id INT,
  old_salary INT,
  new_salary INT,
  change_date TIMESTAMP
);

# ---------------------------------------------------------------------- #
# TRIGGERS FOR LOG OF MIN SALARY CHANGE                                  #
# ---------------------------------------------------------------------- #

DELIMITER //
CREATE TRIGGER log_salary_changes
AFTER UPDATE ON JOB                        
FOR EACH ROW                                     
BEGIN
  IF OLD.min_salary != NEW.min_salary THEN               
    INSERT INTO salary_change_logs (job_id, old_min_salary, new_min_salary, change_date) 
    VALUES (NEW.job_id, OLD.min_salary, NEW.min_salary, NOW());   
  END IF;
END;
//
DELIMITER ;

# ---------------------------------------------------------------------- #
# TRIGGERS FOR LOG OF MAX SALARY CHANGE                                  #
# ---------------------------------------------------------------------- #

DELIMITER //
CREATE TRIGGER log_salary_changes_max
AFTER UPDATE ON JOB                        
FOR EACH ROW                                     
BEGIN
  IF OLD.max_salary != NEW.max_salary THEN               
    INSERT INTO salary_change_logs_max (job_id, old_max_salary, new_max_salary, change_date) 
    VALUES (NEW.job_id, OLD.max_salary, NEW.max_salary, NOW());   
  END IF;
END;
//
DELIMITER ;

# ---------------------------------------------------------------------- #
# TRIGGERS NOTIFY THE HR OF MIN SALARY CHANGES.                          #
# ---------------------------------------------------------------------- #

DELIMITER //
CREATE TRIGGER salary_change_notify
BEFORE UPDATE ON JOB
FOR EACH ROW 
BEGIN
  IF OLD.min_salary != NEW.min_salary THEN
    INSERT INTO notifications (job_id, message, notification_time) VALUES (NEW.job_id, 'Salary has been updated.', NOW());
  END IF;
END; 
//
DELIMITER ;


# ---------------------------------------------------------------------- #
# TRIGGERS NOTIFY THE HR OF MAX SALARY CHANGES.                          #
# ---------------------------------------------------------------------- #

DELIMITER //
CREATE TRIGGER salary_change_notify_max
BEFORE UPDATE ON JOB
FOR EACH ROW 
BEGIN
  IF OLD.max_salary != NEW.max_salary THEN
    INSERT INTO notifications (job_id, message, notification_time) VALUES (NEW.job_id, 'Salary has been updated.', NOW());
  END IF;
END; 
//
DELIMITER ;






