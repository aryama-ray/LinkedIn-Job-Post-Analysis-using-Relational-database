

# ---------------------------------------------------------------------- #
# DBMS:                  MYSQL 8                                         #
# LAB1 name:             TRIGGER FOR                                     #
#                        APPLIES, EXPIRED JOBS, LOW INTEREST JOBS,       #
#                        SALARY CHANGE, LOGGING AND NOTIFICATION         #
# Author:                GROUP 2                                         #
#                                                                        #
# ---------------------------------------------------------------------- #


# ---------------------------------------------------------------------- #
# TRIGGERS FOR APPLIES IN JOB POSTING.                                   #
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


