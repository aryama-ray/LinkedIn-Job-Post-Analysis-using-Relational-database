#-------------------------------------------------------------------------------------------------------#
# Find which job post has more views, what is the work type and company name, which location and city. 
#-------------------------------------------------------------------------------------------------------#

DROP VIEW IF EXISTS Job_View;

CREATE VIEW Job_View AS
SELECT 
    jp.views, 
    j.job_title, 
    j.formatted_work_type AS work_type, 
    c.name AS company_name, 
    j.location AS job_location, 
    c.city AS company_city
FROM JOBPOST jp
JOIN JOB j ON jp.job_id = j.job_id
JOIN COMPANY c ON j.company_id = c.company_id
ORDER BY jp.views DESC;

SELECT * FROM Job_View;


#-----------------------------------------------------------------------------------------------------------------#
# Result shows each company's ID, name, respective the count of sponsored jobs, and the count of non-sponsored jobs#
#-----------------------------------------------------------------------------------------------------------------#
DROP VIEW IF EXISTS Company_Sponsorship_View;

CREATE VIEW Company_Sponsorship_View AS

SELECT c.company_id, c.name AS company_name,
       COUNT(CASE WHEN j.sponsored = '1' THEN 1 ELSE NULL END) AS sponsored_jobs,
       COUNT(CASE WHEN j.sponsored = '0' THEN 1 ELSE NULL END) AS non_sponsored_jobs
FROM COMPANY c
LEFT JOIN JOB j ON c.company_id = j.company_id
GROUP BY c.company_id, company_name
ORDER BY sponsored_jobs DESC;

SELECT * FROM Company_Sponsorship_View;



