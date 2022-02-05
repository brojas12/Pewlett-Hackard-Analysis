-- SELECT emp_no,
-- 		first_name,
-- 		last_name
-- FROM employees;

-- SELECT title,
-- 		from_date,
-- 		to_date
-- FROM titles

SELECT e.emp_no,
		e.first_name,
		e.last_name,
		titles.title,
		titles.from_date,
		titles.to_date
INTO retirment_titles
FROM employees as e
INNER JOIN titles
ON (e.emp_no=titles.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no


SELECT DISTINCT ON (rt.emp_no) emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirment_titles as rt
WHERE (rt.to_date='9999-01-01')
ORDER BY rt.emp_no, to_date DESC;

SELECT COUNT (ut.title),
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC

SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		titles.title
FROM employees as e
INTO mentorship_eligibility
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
INNER JOIN titles
ON (e.emp_no=titles.emp_no)
WHERE (de.to_date='9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no