
# ---------------------------------------------------------------------- #
# DBMS:                  MYSQL 8                                         #
# LAB1 name:             VIEWS,PROCEDURE AND TRIGGER FOR                 #
#                        SKILL WISE JOB REQUIREMENT,SALARY ANALYSIS      #
# Author:                GROUP 2                                         #
#                                                                        #
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
#  Add View for Job Seeker: JOB TITLE WISE SKILL REQUIREMENT             #
# ---------------------------------------------------------------------- #
DROP VIEW IF EXISTS `JOB TITLE WISE SKILL REQUIREMENT`; 
CREATE VIEW `JOB TITLE WISE SKILL REQUIREMENT` AS
SELECT      JOB.job_id, JOB.job_title,JOBSKILL.skill,CASE WHEN JOBPOST.application_url='unknown' THEN JOBPOST.job_posting_url
                                                          ELSE JOBPOST.application_url
                                                          END AS apply_page
FROM JOB LEFT JOIN JOBSKILL ON JOB.job_id=JOBSKILL.job_id LEFT JOIN JOBPOST ON JOB.job_id=JOBPOST.job_id
ORDER BY JOB.job_title;

# ------------------------------------------------------------------------------------------ #
#  Select View as Job Seeker: JOB TITLE WISE SKILL REQUIREMENT AND APPLICATION LINK          #
# ------------------------------------------------------------------------------------------ #

SELECT *
FROM `JOB TITLE WISE SKILL REQUIREMENT`;
# ------------------------------------------------------------------------------------------------------------------ #
#  Add View for Job Seeker: EXPERIENCE LEVEL WISE  TOP 5  Avergae PAY SCALE FOR DIFFERENT JOB TITLE                  #
# ------------------------------------------------------------------------------------------------------------------ #            
DROP VIEW IF EXISTS `EXPERIENCE LEVEL WISE TOP 5 SALARY WITH DIFFERENT JOB TITLE`; 
CREATE VIEW `EXPERIENCE LEVEL WISE TOP 5 SALARY WITH DIFFERENT JOB TITLE` AS
SELECT *
FROM
(SELECT distinct job_title,experience_level,avg_salary,
         dense_RANK() OVER(PARTITION BY experience_level ORDER BY avg_salary  DESC) AVG_SAL_RANK
FROM 
(SELECT      JOB.job_title,JOB.formatted_experience_level AS experience_level,
                 ROUND(((JOB.max_salary-JOB.min_salary)/2),2) as avg_salary
FROM JOB LEFT JOIN JOBSKILL ON JOB.job_id=JOBSKILL.job_id) TEMP) TEMP2
WHERE TEMP2.AVG_SAL_RANK <=5;
 
            
# ------------------------------------------------------------------------------------------------------------------------ #
#  Select View as Job Seeker: `EXPERIENCE LEVEL WISE TOP 5 AVERAGE PAY SCALE WITH DIFFERENT JOB TITLE`                    #
# ------------------------------------------------------------------------------------------------------------------------ #

SELECT *
FROM `EXPERIENCE LEVEL WISE TOP 5 SALARY WITH DIFFERENT JOB TITLE`;
            
# ---------------------------------------------------------------------- #
#  Add View for Job Seeker: Top 5 SKILLS WITH HIGHEST REQUIREMENT        #
# ---------------------------------------------------------------------- #            

DROP VIEW IF EXISTS `TOP 5 SKILLS WITH HIGHEST REQUIREMENT`; 
CREATE VIEW `TOP 5 SKILLS WITH HIGHEST REQUIREMENT` AS
SELECT   JOBSKILL.skill,COUNT(JOB.job_id) as 'num_of_jobs'
FROM JOB LEFT JOIN JOBSKILL ON JOB.job_id=JOBSKILL.job_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5; 

# ------------------------------------------------------------------------------------------------------------------------ #
#  Select View as Job Seeker: Top 5 SKILLS WITH HIGHEST REQUIREMENT                     #
# ------------------------------------------------------------------------------------------------------------------------ #

SELECT *
FROM `TOP 5 SKILLS WITH HIGHEST REQUIREMENT`;

# -------------------------------------------------------------------------------------------- #
#  Add View for Job Seeker: COMPANIES OFFERING JOB WITH SKILLS WITH HIGHEST REQUIREMENT        #
# -------------------------------------------------------------------------------------------- # 

DROP VIEW IF EXISTS `COMPANY WISE JOB REQUIREMENT WITH TOP SKILLS`; 
CREATE VIEW `COMPANY WISE JOB REQUIREMENT WITH TOP SKILLS` AS
SELECT DISTINCT COMPANY.name AS COMPANY, JOBSKILL.skill AS SKILLS, COUNT(JOBSKILL.skill) 
           OVER(PARTITION BY JOB.company_id,JOBSKILL.skill order by COMPANY.name) AS 'num_of_jobs'
FROM JOB LEFT JOIN JOBSKILL ON JOB.job_id=JOBSKILL.job_id LEFT JOIN COMPANY ON JOB.company_id=COMPANY.company_id
WHERE JOBSKILL.skill IN ('IT',
'SALE',
'MGMT',
'ENG',
'MNFC')
ORDER BY 3 DESC,1 ASC;

# ------------------------------------------------------------------------------------------------------------------------ #
#  Select View as Job Seeker: COMPANY WISE JOB REQUIREMENT WITH TOP SKILLS                    #
# ------------------------------------------------------------------------------------------------------------------------ #

SELECT *
FROM `COMPANY WISE JOB REQUIREMENT WITH TOP SKILLS`;
# -------------------------------------------------------------------------------------------------- #
#  STORED PROCEDURE "COMPANY AND TITLE BASED JOB SEARCH, VIEW AND APPLY"                             #
# -------------------------------------------------------------------------------------------------- # 
# WHEN JOB POST TABLE HAS ENTRY FOR APPLICATION URL FOR A JOB POSTED BY THE COMPANY FOR A            #
# PARTICULAR TITLE JOB SEEKER CAN VIEW AND APPLY FOR THAT JOB. BUT WHEN APPLICATION URL IS UNKNOWN   #
# JOB SEEKER CAN VIEW THE JOB POST ONLY ON LINKEDIN JOB POST URL                                     #
#----------------------------------------------------------------------------------------------------#
DROP PROCEDURE IF EXISTS `Company and Job Ttile based Job Search-View-Apply`;
SET SQL_SAFE_UPDATES = 0;
DELIMITER $$

CREATE PROCEDURE `Company and Job Ttile based Job Search-View-Apply` (in InCompany varchar(255),in InTitle varchar(255))
BEGIN
   DECLARE JOB_APPLY_CNT INT DEFAULT 0;
   DECLARE APPLURL VARCHAR(255);
   DECLARE JPOSTURL VARCHAR(255);
   DECLARE J_ID BIGINT(100);
   DECLARE C_ID BIGINT(100);
   DECLARE COUNTER INT DEFAULT 0;

   
DECLARE END_OF_CUR INT DEFAULT 0;
--    
DECLARE CURSOR_URL
     CURSOR FOR 
     SELECT application_url,job_posting_url,JOB.job_id
              FROM COMPANY INNER JOIN JOB ON COMPANY.company_id=JOB.company_id LEFT JOIN JOBPOST ON JOB.job_id=JOBPOST.job_id
              WHERE COMPANY.name=InCompany AND JOB.job_title=InTitle;
  
DECLARE CONTINUE HANDLER 
         FOR NOT FOUND SET END_OF_CUR = 1;
       
OPEN CURSOR_URL;

WHILE END_OF_CUR<>1 DO
IF APPLURL<>'unknown' THEN
 UPDATE JOBPOST
     	SET views=views+1, applies=applies+1
        WHERE JOBPOST.application_url=APPLURL AND JOBPOST.job_id=J_ID;
        set COUNTER =COUNTER+1;
ELSE IF APPLURL='unknown' THEN
 UPDATE JOBPOST
     	SET views=views+1
        WHERE JOBPOST.application_url=APPLURL AND JOBPOST.job_posting_url=JPOSTURL AND JOBPOST.job_id=J_ID;
        set COUNTER =COUNTER+1;
  END IF;      
END IF;
 FETCH NEXT FROM CURSOR_URL INTO APPLURL,JPOSTURL,J_ID;

END WHILE;

CLOSE CURSOR_URL;


END $$

DELIMITER ;

# -------------------------------------------------------------------------------------------- #
#  CALLING STORED PROCEDURE "COMPANY AND TITLE BASED JOB SEARCH, VIEW AND APPLY"                       #
# -------------------------------------------------------------------------------------------- # 
CALL `Company and Job Ttile based Job Search-View-Apply`('Amazon','Software Development Engineer II, I');
SELECT *
FROM `JOB_VIEW_APPLY_LOG_TABLE`;

SELECT DISTINCT application_url , JOBPOST.company_id,JOBPOST.job_id
     FROM COMPANY INNER JOIN JOB ON COMPANY.company_id=JOB.company_id LEFT JOIN JOBPOST ON JOB.job_id=JOBPOST.job_id
     WHERE COMPANY.name='Amazon' AND JOB.job_title='Software Development Engineer II, I';
  SELECT COUNT(*) AS JOB_CNT
     FROM COMPANY INNER JOIN JOB ON COMPANY.company_id=JOB.company_id LEFT JOIN JOBPOST ON JOB.job_id=JOBPOST.job_id
     WHERE COMPANY.name='Amazon' AND JOB.job_title='Software Development Engineer II, I' ;   
# -------------------------------------------------------------------------------------------- #
#  TRIGGER "UPDATE LOG TABLE UPON JOB VIEW AND APPLICATION UPDATE                              #
# -------------------------------------------------------------------------------------------- # 

DROP TABLE IF EXISTS `JOB_VIEW_APPLY_LOG_TABLE`;
CREATE TABLE `JOB_VIEW_APPLY_LOG_TABLE` (
    `user` VARCHAR(45) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `viewupdate_timestamp` timestamp
);
DROP TRIGGER IF EXISTS AFTER_JOBVIEW_APPLY_UPDATE;
DELIMITER $$
CREATE TRIGGER AFTER_JOBVIEW_APPLY_UPDATE
AFTER UPDATE
  ON JOBPOST FOR EACH ROW
BEGIN
   IF (new.views <> old.views) 
      THEN INSERT INTO JOB_VIEW_APPLY_LOG_TABLE(user,description,viewupdate_timestamp)
        VALUES(SUBSTRING_INDEX(user(),'@',1),'viewed  jobpost',current_timestamp());
	IF (new.applies <> old.applies) 
         THEN INSERT INTO JOB_VIEW_APPLY_LOG_TABLE(user,description,viewupdate_timestamp)
          VALUES(SUBSTRING_INDEX(user(),'@',1),'applied jobpost',current_timestamp());
	END IF;
   END IF;
END $$
   
DELIMITER ;


-- -------------------------------------
--            END OF CODE             --
-- -------------------------------------

