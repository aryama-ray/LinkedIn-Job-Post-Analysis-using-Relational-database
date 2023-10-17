# ---------------------------------------------------------------------- #
# DBMS:                  MYSQL 8                                         #
# Purpose:               USER CREATION,GRANT AND REVOKE ACCESS           #
#                        PRIVILEGES                                      #
# Author:                GROUP 2                                         #
#                                                                        #
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
#  CREATE USERS: JOB_SEEKER, HR MANAGER                                  #
# ---------------------------------------------------------------------- #
-- FOR JOB SEEKER USER
CREATE USER 'JOB_SEEKER'@'localhost'
  IDENTIFIED BY 'password';
  
  
 -- FOR HR MANAGER
 CREATE USER 'HR_MANAGER'@'localhost'
  IDENTIFIED BY 'password';
  
  
  -- HR MANAGER HAS SELECT, INSERT, DELETE, UPDATE ACCESS TO DATABASE
  GRANT SELECT, INSERT, DELETE, UPDATE ON DATA225_LAB0.* TO 'HR_MANAGER'@'localhost';
  
  -- JOB SEEKER HAS SELECT ACCESS TO ALL TABLES IN THE DATABASE
  GRANT SELECT ON DATA225_LAB0.* TO 'JOB_SEEKER'@'localhost';
  
  -- JOB SEEKER HAS UPDATE ACCESS TO ALL TABLES IN THE DATABASE
  GRANT UPDATE ON DATA225_LAB0.JOBPOST TO 'JOB_SEEKER'@'localhost';
  
# ---------------------------------------------------------------------- #
#  END OF CODE                                                           #
# ---------------------------------------------------------------------- #

  