# ---------------------------------------------------------------------- #
# DBMS:                  MYSQL 8                                         #
# LAB1 name:             VIEWS,PROCEDURE AND TRIGGER FOR                 #
#                        SKILL WISE JOB REQUIREMENT,SALARY ANALYSIS      #
# Author:                GROUP 2                                         #
#                                                                        #
# ---------------------------------------------------------------------- #
#####################################################################################################################################################################
#																																									#																																									#
# Range of insights derived to  analysis of company , benifits , speciality and job data. It provides a structured way to understand various aspects of the dataset #
#																																									#																																								#
#####################################################################################################################################################################


# -------------------------------------------------------------------------------------------------------------#
#(1)  VIEW TO FIND most common benifits provided by the companies and which company provides it the most.      #
# -------------------------------------------------------------------------------------------------------------#

SELECT DISTINCT(type) FROM BENEFIT;-- There are 12 distinct benefits 


-- Drop the view if it exists
DROP VIEW IF EXISTS `Common Benifits`;

-- Create a new view named "Common Benifits"
CREATE VIEW `Common Benifits` AS
SELECT 
    b.type AS Benefit_Type, 
    COUNT(*) AS Popularity_Count,
    (
        -- Subquery to find the most popular company for each benefit type
        SELECT c.name 
        FROM BENEFIT b2
        INNER JOIN JOB j ON b2.job_id = j.job_id
        INNER JOIN COMPANY c ON j.company_id = c.company_id
        WHERE b2.type = b.type
        GROUP BY b2.type, c.name
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS MostPopularIn 
FROM BENEFIT b
GROUP BY Benefit_Type
ORDER BY Popularity_Count DESC;

-- Select data from the created view
SELECT * FROM `Common Benifits`;


# -------------------------------------------------------------------------------------------------------------#
#(2) VIEW TO FIND company's total count of specialities 													   #
# -------------------------------------------------------------------------------------------------------------#


DROP VIEW IF EXISTS CompanySpecialtyCounts;

-- Create a view to count the total number of specialties associated with each company.
CREATE VIEW CompanySpecialtyCounts AS
SELECT c.name AS company_name, COUNT(cs.speciality) AS total_specialties
FROM COMPANY c
LEFT JOIN COMP_SPCLTY cs ON c.company_id = cs.company_id
GROUP BY c.name
ORDER BY total_specialties DESC;


SELECT * FROM CompanySpecialtyCounts;

# -------------------------------------------------------------------------------------------------------------#
# (3) VIEW TO FIND lists the specialities for the company with the highest count of specialities 			   #
# -------------------------------------------------------------------------------------------------------------#


DROP VIEW IF EXISTS MostSpecializedCompanySpecialties;

-- Create a view to list the specialties of the company with the highest count of specialties.
CREATE VIEW MostSpecializedCompanySpecialties AS
SELECT c.name AS company_name, cs.speciality
FROM COMPANY c
LEFT JOIN COMP_SPCLTY cs ON c.company_id = cs.company_id
WHERE c.name = (
    -- Subquery to find the company with the highest count of specialties.
    SELECT company_name
    FROM (
        -- Subquery to calculate the total specialties count for each company.
        SELECT c.name AS company_name, COUNT(cs.speciality) AS total_specialties
        FROM COMPANY c
        LEFT JOIN COMP_SPCLTY cs ON c.company_id = cs.company_id
        GROUP BY c.name
        ORDER BY total_specialties DESC
        LIMIT 1
    ) t
);


SELECT * FROM MostSpecializedCompanySpecialties;

# -------------------------------------------------------------------------------------------------------------#
# (4) VIEW TO FIND the Count number of job posting companies in each state of United States					   #
# -------------------------------------------------------------------------------------------------------------#


DROP VIEW IF EXISTS CompanyCountByState;

-- Create a view to count the number of companies in each U.S. state.
CREATE VIEW CompanyCountByState AS
SELECT
    state AS company_state,
    COUNT(DISTINCT company_id) AS NumberOfCompanies
FROM COMPANY
WHERE country = 'US'
GROUP BY state, country
ORDER BY NumberOfCompanies DESC;


SELECT * FROM CompanyCountByState;

# -------------------------------------------------------------------------------------------------------------#
# (5) VIEW TO see the count of different work types offered and Count number of job posting counts by companies#
# -------------------------------------------------------------------------------------------------------------#
-- Drop the view if it exists to ensure a clean environment.
DROP VIEW IF EXISTS WorkTypeCount;

-- Create a view to count the work types offered by companies and the total job posting count.
CREATE VIEW WorkTypeCount AS
SELECT
    c.name AS Company,
    SUM(CASE WHEN j.work_type LIKE '%PART_TIME%' THEN 1 ELSE 0 END) AS 'PART_TIME',
    SUM(CASE WHEN j.work_type LIKE '%FULL_TIME%' THEN 1 ELSE 0 END) AS 'FULL_TIME',
    SUM(CASE WHEN j.work_type LIKE '%INTERNSHIP%' THEN 1 ELSE 0 END) AS 'INTERNSHIP',
    SUM(CASE WHEN j.work_type LIKE '%TEMPORARY%' THEN 1 ELSE 0 END) AS 'TEMPORARY',
    SUM(CASE WHEN j.work_type LIKE '%VOLUNTARY%' THEN 1 ELSE 0 END) AS 'VOLUNTARY',
    SUM(CASE WHEN j.work_type LIKE '%OTHER%' THEN 1 ELSE 0 END) AS 'OTHER',
    COUNT(j.work_type) AS TotalPositions
FROM COMPANY c
JOIN JOB j ON c.company_id = j.company_id
WHERE j.work_type IN ('PART_TIME', 'FULL_TIME', 'INTERNSHIP', 'TEMPORARY', 'VOLUNTARY', 'OTHER')
GROUP BY Company
ORDER BY TotalPositions DESC;


SELECT * FROM WorkTypeCount;


-- ---------------------------------------------------------- STORED PROCEDURE -----------------------------------------------------------------------------




# -------------------------------------------------------------------------------------------------------------#
# (6) STORED PROCEDURE to see the internship opportunities based on the user preferences					   #
# -------------------------------------------------------------------------------------------------------------#
# -----------------------------------------------------------------------------------------------------------------------------------------------#
-- Here   IN p_user_id INT, IN p_location VARCHAR(255),IN p_skillset VARCHAR(255) are the parameters (inputs) that contains user preferences 
-- j.work_type = 'Internship'
-- AND j.location = p_location
-- AND js.skill = p_skillset
-- this part of the query is to show appropriate internship opportunity to the user ,
-- where the work type is Internship, according to their preferred inputs in the beginning
# -----------------------------------------------------------------------------------------------------------------------------------------------#
-- Drop the procedure if it exists to ensure a clean environment.
DROP PROCEDURE IF EXISTS InternshipSP;


DELIMITER $$

-- Create a stored procedure to retrieve internship opportunities based on user preferences.
CREATE PROCEDURE InternshipSP(
    IN parameter_location VARCHAR(255),
    IN parameter_skillset VARCHAR(255)
)
BEGIN
    -- Select relevant job details for internships.
    SELECT
        j.job_title,
        j.company_id,
        j.location,
        j.min_salary,
        j.max_salary,
        j.pay_period, 
        js.skill

    FROM
        JOB j
    INNER JOIN
        JOBSKILL js ON j.job_id = js.job_id
    WHERE
        j.work_type = 'Internship'
        AND j.location = parameter_location
        AND js.skill = parameter_skillset;
END $$

DELIMITER ;
-- 
-- Example: Calling the InternshipSP procedure where the user input for location is 'Los Angeles, CA' and for skill is EDU';
--        
CALL InternshipSP('Los Angeles, CA', 'EDU');
-- Shows the internship opportunites as per the inputs(preferences)

-- -------------------------------------
--            END OF CODE             --
-- -------------------------------------