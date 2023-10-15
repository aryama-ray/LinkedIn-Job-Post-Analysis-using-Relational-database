
# ---------------------------------------------------------------------- #
# DBMS:                  MYSQL 8                                         #
# LAB1 name:             LINKEDIN JOB POSTING ANALYSIS                   #
# Author:                GROUP 2                                         #
#                                                                        #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS DATA225_LAB0;

CREATE DATABASE IF NOT EXISTS DATA225_LAB0;

USE DATA225_LAB0;

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
    `job_title`  VARCHAR(35),
    `max_salary` DECIMAL(12,2),
    `min_salary` DECIMAL(12,2),
    `pay_period` VARCHAR(35),
	`formatted_work_type` VARCHAR(35),
    `location` VARCHAR(35),
	`formatted_experience_level` VARCHAR(35),
    `sponsored` VARCHAR(35),
    `work_type` VARCHAR(35),
    CONSTRAINT `PK_JOB` PRIMARY KEY (`job_id`,`company_id`)
);

CREATE INDEX `job_title` ON `JOB` (`job_title`);
CREATE INDEX `company_id` ON `JOB` (`company_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "JOB"                         #
# ---------------------------------------------------------------------- #
INSERT INTO JOB(job_id, company_id, job_title, max_salary, min_salary, pay_period, formatted_work_type, location, formatted_experience_level, sponsored, work_type)
SELECT job_id,company_id,title,max_salary,min_salary,pay_period,formatted_work_type, location, formatted_experience_level, sponsored, work_type
FROM `DATA225_LAB1`.`preprocessed_job_postings`;


# ---------------------------------------------------------------------- #
# CREATE TABLE "JOB_POST"                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `JOBPOST`;
CREATE TABLE `JOBPOST` (
    `job_id`  BIGINT(100) NOT NULL,
	`company_id` BIGINT(100) NOT NULL,
    `applies` INT(12),
    `views` INT(12),
    `job_posting_url` VARCHAR(35),
    `application_url` VARCHAR(35),
    `application_type` VARCHAR(35),
	`posting_domain` VARCHAR(35),
    
    CONSTRAINT `PK_JOB` PRIMARY KEY (`job_id`)
);


CREATE INDEX `company_id` ON `JOBPOST` (`company_id`,`job_id`);

# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "JOBPOST"                     #
# ---------------------------------------------------------------------- #
INSERT INTO JOBPOST(job_id,company_id,views, job_posting_url,application_url,application_type,posting_domain)
SELECT job_id,company_id,views,job_posting_url,application_url,application_type,posting_domain
FROM `DATA225_LAB1`.`preprocessed_job_postings`;


# ---------------------------------------------------------------------- #
# CREATE TABLE "BENEFIT".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `BENEFIT`;
CREATE TABLE `BENEFIT` (
    `job_id` BIGINT(12) NOT NULL,
    `inferred` VARCHAR(35),
    `type` VARCHAR(35)
);
CREATE INDEX `job_id` ON `BENEFIT` (`job_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "BENEFIT"                     #
# ---------------------------------------------------------------------- #
INSERT INTO BENEFIT(`job_id`,`inferred`,`type`)
SELECT `job_id`,`inferred`,`type`
FROM `DATA225_LAB1`.`benefits`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "JOBSKILL".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `JOBSKILL`;
CREATE TABLE `JOBSKILL` (
    `job_id` BIGINT(100) NOT NULL,
    `skill` VARCHAR(255)
);
CREATE INDEX `job_id` ON `JOBSKILL` (`job_id`);
# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "JOBSKILL"                     #
# ---------------------------------------------------------------------- #
INSERT INTO JOBSKILL(`job_id`,`skill`)
SELECT `job_id`,`skill_abr`
FROM `DATA225_LAB1`.`job_skills`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "COMPANY".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `COMPANY`;
CREATE TABLE `COMPANY` (
    `company_id` BIGINT(100) NOT NULL,
    `name` VARCHAR(255),
    `state` VARCHAR(255),
    `city` VARCHAR(255),
    `country` VARCHAR(255),
    `company_url`  VARCHAR(255),
    CONSTRAINT `PK_COMPANY` PRIMARY KEY (`company_id`)
);

# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "COMPANY"                     #
# ---------------------------------------------------------------------- #
INSERT INTO COMPANY(`company_id`,`name`,`state`,`city`,`country`,`company_url`)
SELECT `company_id`,`name`,`state`,`city`,`country`,`url`
FROM `DATA225_LAB1`.`companies`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "EMP_CNT".                                                #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `EMP_CNT`;
CREATE TABLE `EMP_CNT` (
    `company_id` BIGINT(100) NOT NULL,
    `employee_count` BIGINT(12),
    `follower_count` BIGINT(12),
CONSTRAINT `PK_COMPANY` PRIMARY KEY (`company_id`)
);

# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "EMP_CNT"                     #
# ---------------------------------------------------------------------- #
INSERT INTO `EMP_CNT`(`company_id`,`employee_count`,`follower_count`)
SELECT `company_id`,`employee_count`,`follower_count`
FROM `DATA225_LAB1`.`employee_counts`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "COMP_INDUSTRY".                                           #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `COMP_INDUSTRY`;
CREATE TABLE `COMP_INDUSTRY` (
    `company_id` BIGINT(100) NOT NULL,
    `industry` VARCHAR(255)
);

# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "COMP_INDUSTRY"               #
# ---------------------------------------------------------------------- #
INSERT INTO COMP_INDUSTRY(`company_id`,`industry`)
SELECT `company_id`,`industry`
FROM `DATA225_LAB1`.`company_industries`;

# ---------------------------------------------------------------------- #
# CREATE TABLE "COMP_SPCLTY".                                           #
# ---------------------------------------------------------------------- #
DROP TABLE IF EXISTS `COMP_SPCLTY`;
CREATE TABLE `COMP_SPCLTY` (
    `company_id` BIGINT(100) NOT NULL,
    `speciality` VARCHAR(255)
);

# ---------------------------------------------------------------------- #
# INSERT DATA FROM JOB_POSTINGS INTO TABLE "COMP_SPCLTY"                 #
# ---------------------------------------------------------------------- #
INSERT INTO COMP_SPCLTY(`company_id`,`speciality`)
SELECT `company_id`,`speciality`
FROM `DATA225_LAB1`.`company_specialities`;


# ---------------------------------------------------------------------- #
# Foreign key constraints                                                #
# ---------------------------------------------------------------------- #

SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE `DATA225_LAB0`.`JOB` ADD CONSTRAINT `fk_JOB_COMPANY`
    FOREIGN KEY (`company_id`)
    REFERENCES `DATA225_LAB0`.`COMPANY` (`company_id`);
    
ALTER TABLE `DATA225_LAB0`.`BENEFIT` ADD CONSTRAINT `fk_BENEFIT_JOB1`
    FOREIGN KEY (`job_id`)
    REFERENCES `DATA225_LAB0`.`JOB` (`job_id`);
    
ALTER TABLE `DATA225_LAB0`.`COMP_INDUSTRY` ADD CONSTRAINT `fk_COMP_INDUSTRY_COMPANY1`
    FOREIGN KEY (`company_id`)
    REFERENCES `DATA225_LAB0`.`COMPANY` (`company_id`);
    
 ALTER TABLE `DATA225_LAB0`.`COMP_SPCLTY` ADD CONSTRAINT `fk_COMP_SPCLTY_COMPANY1`
    FOREIGN KEY (`company_id`)
    REFERENCES `DATA225_LAB0`.`COMPANY` (`company_id`);
    
ALTER TABLE `DATA225_LAB0`.`EMP_CNT` ADD  CONSTRAINT `fk_EMP_CNT_COMPANY1`
    FOREIGN KEY (`company_id`)
    REFERENCES `DATA225_LAB0`.`COMPANY` (`company_id`);
    
ALTER TABLE `DATA225_LAB0`.`JOBPOST` ADD  CONSTRAINT `fk_JOBPOST_JOB1`
    FOREIGN KEY (`job_id` , `company_id`)
    REFERENCES `DATA225_LAB0`.`JOB` (`job_id` , `company_id`);
    
ALTER TABLE `DATA225_LAB0`.`JOBSKILL` ADD  CONSTRAINT `fk_JOBSKILL_JOB1`
    FOREIGN KEY (`job_id`)
    REFERENCES `DATA225_LAB0`.`JOB` (`job_id`);
    
    
# ---------------------------------------------------------------------- #
<<<<<<< HEAD:LinkedinJobAnalysis_SchemaDesign.sql
#             END OF SCHEMA DESIGN                                       #
# ---------------------------------------------------------------------- #
