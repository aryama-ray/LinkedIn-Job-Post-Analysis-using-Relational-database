
# ---------------------------------------------------------------------- #
# DBMS:                  MYSQL 8                                         #
# LAB1 name:             LINKEDIN JOB POSTING ANALYSIS                   #
# Author:                GROUP 2                                         #
#                                                                        #
# ---------------------------------------------------------------------- #
USE DBLAB;
# ---------------------------------------------------------------------- #
# Tables  CREATION                                                       #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# CREATE TABLE "JOB"                                                     #
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
FROM `company_industries`;

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
#             END OF SCHEMA DESIGN                                       #
# ---------------------------------------------------------------------- #

