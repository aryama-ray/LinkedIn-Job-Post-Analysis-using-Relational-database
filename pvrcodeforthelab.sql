# Data_log table and its triggers : for HR


DELIMITER //
CREATE TABLE `DATA_LOG` (
    `log_id` INT AUTO_INCREMENT,
    `table_name` VARCHAR(100),
    `operation` VARCHAR(500),
    `operation_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`log_id`)
);

CREATE PROCEDURE `insert_log`(IN table_name VARCHAR(100), IN operation VARCHAR(50))
BEGIN
    INSERT INTO LOG(table_name, operation)
    VALUES (table_name, operation);
END;

CREATE TRIGGER `JOB_after_insert` 
AFTER INSERT ON `JOB`
FOR EACH ROW 
CALL insert_log('JOB', 'INSERT');

CREATE TRIGGER `JOB_after_update` 
AFTER UPDATE ON `JOB`
FOR EACH ROW 
CALL insert_log('JOB', 'UPDATE');

CREATE TRIGGER `JOB_after_delete` 
AFTER DELETE ON `JOB`
FOR EACH ROW 
CALL insert_log('JOB', 'DELETE');



CREATE TRIGGER `JOBPOST_after_insert` 
AFTER INSERT ON `JOBPOST`
FOR EACH ROW 
CALL insert_log('JOBPOST', 'INSERT');

CREATE TRIGGER `JOBPOST_after_update` 
AFTER UPDATE ON `JOBPOST`
FOR EACH ROW 
CALL insert_log('JOBPOST', 'UPDATE');

CREATE TRIGGER `JOBPOST_after_delete` 
AFTER DELETE ON `JOBPOST`
FOR EACH ROW 
CALL insert_log('JOBPOST', 'DELETE');



CREATE TRIGGER `JOBSKILL_after_insert` 
AFTER INSERT ON `JOBSKILL`
FOR EACH ROW 
CALL insert_log('JOBSKILL', 'INSERT');

CREATE TRIGGER `JOBSKILL_after_update` 
AFTER UPDATE ON `JOBSKILL`
FOR EACH ROW 
CALL insert_log('JOBSKILL', 'UPDATE');

CREATE TRIGGER `JOBSKILL_after_delete` 
AFTER DELETE ON `JOBSKILL`
FOR EACH ROW 
CALL insert_log('JOBSKILL', 'DELETE');



CREATE TRIGGER `EMP_CNT_after_insert` 
AFTER INSERT ON `EMP_CNT`
FOR EACH ROW 
CALL insert_log('EMP_CNT', 'INSERT');

CREATE TRIGGER `EMP_CNT_after_update` 
AFTER UPDATE ON `EMP_CNT`
FOR EACH ROW 
CALL insert_log('EMP_CNT', 'UPDATE');

CREATE TRIGGER `EMP_CNT_after_delete` 
AFTER DELETE ON `EMP_CNT`
FOR EACH ROW 
CALL insert_log('EMP_CNT', 'DELETE');



CREATE TRIGGER `COMP_SPCLTY_after_insert` 
AFTER INSERT ON `COMP_SPCLTY`
FOR EACH ROW 
CALL insert_log('COMP_SPCLTY', 'INSERT');

CREATE TRIGGER `COMP_SPCLTY_after_update` 
AFTER UPDATE ON `COMP_SPCLTY`
FOR EACH ROW 
CALL insert_log('COMP_SPCLTY', 'UPDATE');

CREATE TRIGGER `COMP_SPCLTY_after_delete` 
AFTER DELETE ON `COMP_SPCLTY`
FOR EACH ROW 
CALL insert_log('COMP_SPCLTY', 'DELETE');



CREATE TRIGGER `COMP_INDUSTRY_after_insert` 
AFTER INSERT ON `COMP_INDUSTRY`
FOR EACH ROW 
CALL insert_log('COMP_INDUSTRY', 'INSERT');

CREATE TRIGGER `COMP_INDUSTRY_after_update` 
AFTER UPDATE ON `COMP_INDUSTRY`
FOR EACH ROW 
CALL insert_log('COMP_INDUSTRY', 'UPDATE');

CREATE TRIGGER `COMP_INDUSTRY_after_delete` 
AFTER DELETE ON `COMP_INDUSTRY`
FOR EACH ROW 
CALL insert_log('COMP_INDUSTRY', 'DELETE');


CREATE TRIGGER `COMPANY_after_insert` 
AFTER INSERT ON `COMPANY`
FOR EACH ROW 
CALL insert_log('COMPANY', 'INSERT');

CREATE TRIGGER `COMPANY_after_update` 
AFTER UPDATE ON `COMPANY`
FOR EACH ROW 
CALL insert_log('COMPANY', 'UPDATE');

CREATE TRIGGER `COMPANY_after_delete` 
AFTER DELETE ON `COMPANY`
FOR EACH ROW 
CALL insert_log('COMPANY', 'DELETE');



CREATE TRIGGER `BENEFIT_after_insert` 
AFTER INSERT ON `BENEFIT`
FOR EACH ROW 
CALL insert_log('BENEFIT', 'INSERT');

CREATE TRIGGER `BENEFIT_after_update` 
AFTER UPDATE ON `BENEFIT`
FOR EACH ROW 
CALL insert_log('BENEFIT', 'UPDATE');

CREATE TRIGGER `BENEFIT_after_delete` 
AFTER DELETE ON `BENEFIT`
FOR EACH ROW 
CALL insert_log('BENEFIT', 'DELETE');

//



# Labour Cost View: This view, along with its associated procedure, helps the HR department understand each company's labour cost. for HR




CREATE VIEW CompanyBudgetsView AS
SELECT COMPANY.name, SUM(JOB.max_salary) as total_budget
FROM COMPANY
JOIN JOB ON COMPANY.company_id = JOB.company_id
GROUP BY COMPANY.company_id, COMPANY.name;


# Application View: This view aids the HR department in understanding how many applications each company has received. It provides insights into which companies are attracting more applicants, allowing other companies to make necessary adjustments. for HR





CREATE VIEW TotalApplications AS
SELECT c.name AS CompanyName, SUM(jp.applies) AS TotalApplications
FROM COMPANY c
JOIN JOBPOST jp ON c.company_id = jp.company_id
GROUP BY c.name ORDER BY TotalApplications DESC;








# Job Details Procedure: This procedure takes a job_id as input and returns all details associated with that job_id and company_id. for USER

DELIMITER //
CREATE PROCEDURE GetAllJobDetails(IN job_id BIGINT)
BEGIN
    SELECT 
        j.*,
        jp.*,
        b.type AS benefit_type,
        js.skill,
        c.*,
        e.employee_count,
        e.follower_count,
        ci.industry,
        cs.speciality
    FROM JOB j
    JOIN JOBPOST jp ON j.job_id = jp.job_id
    LEFT JOIN BENEFIT b ON j.job_id = b.job_id
    LEFT JOIN JOBSKILL js ON j.job_id = js.job_id
    JOIN COMPANY c ON j.company_id = c.company_id
    LEFT JOIN EMP_CNT e ON c.company_id = e.company_id
    LEFT JOIN COMP_INDUSTRY ci ON c.company_id = ci.company_id
    LEFT JOIN COMP_SPCLTY cs ON c.company_id = cs.company_id
    WHERE j.job_id = job_id;
END //




# Delete Job Procedure: This procedure takes a job_id as input and deletes all details associated with that job_id. for HR


DELIMITER $$

CREATE PROCEDURE delete_job_data(IN job_id BIGINT(100), IN company_id BIGINT(100))
BEGIN
    DELETE FROM `JOBPOST` WHERE `job_id` = job_id AND `company_id` = company_id;
    DELETE FROM `BENEFIT` WHERE `job_id` = job_id;
    DELETE FROM `JOBSKILL` WHERE `job_id` = job_id;
    DELETE FROM `JOB` WHERE `job_id` = job_id AND `company_id` = company_id;
END$$

DELIMITER ;

# Delete Company prodecure : for HR

DELIMITER $$

CREATE PROCEDURE delete_company_data(IN company_id BIGINT(100))
BEGIN
    DELETE FROM `EMP_CNT` WHERE `company_id` = company_id;
    DELETE FROM `COMP_INDUSTRY` WHERE `company_id` = company_id;
    DELETE FROM `COMP_SPCLTY` WHERE `company_id` = company_id;
    DELETE FROM `JOBPOST` WHERE `company_id` = company_id;
    DELETE FROM `JOB` WHERE `company_id` = company_id;
    DELETE FROM `COMPANY` WHERE `company_id` = company_id;
END$$

DELIMITER ;



# Archived Table: An archived table was created for all the job_id details which are being filled or removed. for HR

CREATE TABLE `ARCHIVE` (
    `job_id` BIGINT(100),
    `company_id` BIGINT(100),
    `job_title`  VARCHAR(500),
    `max_salary` DECIMAL(12,2),
    `min_salary` DECIMAL(12,2),
    `pay_period` VARCHAR(100),
	`formatted_work_type` VARCHAR(100),
    `location` VARCHAR(1000),
	`formatted_experience_level` VARCHAR(100),
    `sponsored` VARCHAR(100),
    `work_type` VARCHAR(100),
    `applies` INT(12),
    `views` INT(12),
    `job_posting_url` VARCHAR(500),
    `application_url` VARCHAR(1000),
    `application_type` VARCHAR(500),
	`posting_domain` VARCHAR(500),
    `type` VARCHAR(100),
    `skill` VARCHAR(255),
    `name` VARCHAR(500),
    `state` VARCHAR(500),
    `city` VARCHAR(500),
    `country` VARCHAR(500),
    `company_url`  VARCHAR(500),
    `employee_count` BIGINT(12),
    `follower_count` BIGINT(12),
    `industry` VARCHAR(255),
	`speciality` VARCHAR(5000),
	`comment` TEXT
);


# Archive Procedure: A procedure was written to fill the archived table. for HR

DELIMITER $$

CREATE PROCEDURE archive_job_data(IN job_id BIGINT(100), IN company_id BIGINT(100), IN comment TEXT)
BEGIN
	INSERT INTO ARCHIVE
	SELECT 
		JOB.job_id,
		JOB.company_id,
		JOB.job_title,
		JOB.max_salary,
		JOB.min_salary,
		JOB.pay_period,
		JOB.formatted_work_type,
		JOB.location,
		JOB.formatted_experience_level,
		JOB.sponsored,
		JOB.work_type,
		JOBPOST.applies,
		JOBPOST.views,
		JOBPOST.job_posting_url,
		JOBPOST.application_url,
		JOBPOST.application_type,
		JOBPOST.posting_domain,
		BENEFIT.type,
		JOBSKILL.skill,
		COMPANY.name,
		COMPANY.state,
		COMPANY.city,
		COMPANY.country,
		COMPANY.company_url,
        EMP_CNT.employee_count,
        EMP_CNT.follower_count,
        COMP_INDUSTRY.industry,
        COMP_SPCLTY.speciality,
        comment
	FROM JOB
	LEFT JOIN JOBPOST ON JOB.job_id = JOBPOST.job_id AND JOB.company_id = JOBPOST.company_id
	LEFT JOIN BENEFIT ON JOB.job_id = BENEFIT.job_id
	LEFT JOIN JOBSKILL ON JOB.job_id = JOBSKILL.job_id
	LEFT JOIN COMPANY ON JOB.company_id = COMPANY.company_id
	LEFT JOIN EMP_CNT ON JOB.company_id = EMP_CNT.company_id
	LEFT JOIN COMP_INDUSTRY ON JOB.company_id = COMP_INDUSTRY.company_id
	LEFT JOIN COMP_SPCLTY ON JOB.company_id = COMP_SPCLTY.company_id
	WHERE JOB.job_id = job_id AND JOB.company_id = company_id;
END$$

DELIMITER ;



