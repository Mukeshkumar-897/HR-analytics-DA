select * from hr_1;
select * from hr_2;
select count(*) from hr_1;
select count(*) from hr_2;


# kpi 1
# Average Attrition rate for all Departments
select Department,concat(round((sum(case Attrition when 'yes' then 1 else 0 end)/count(*))*100,2),"%") as avg_attrition 
from hr_1 
group by department
order by department ;

# kpi 2
#Average Hourly rate of Male Research Scientist
select Gender, JobRole, avg(HourlyRate) as avg_hourlyrate 
FROM hr_1 
where gender='male'and jobrole="research scientist";


# kpi 3
#Attrition rate Vs Monthly income stats
select floor(monthlyincome/10000)*10000 as income_bin ,
concat(round(sum(case attrition when 'yes' then 1 else 0 end)/count(*)*100,2),"%") as Atr_rate 
from  hr_1
inner join hr_2
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by income_bin
order by income_bin ;


 # kpi 4
# Average working years for each Department
select hr_1.Department ,round(avg(hr_2.TotalWorkingYears),0) as avg_working_years 
from  hr_1 inner join hr_2 on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by hr_1.Department;

# kpi 5
#Job Role Vs Work Life Balance

select hr_1.jobrole, Case 
when worklifebalance = 1 then "Bad"
when worklifebalance = 2 then "Poor"
when worklifebalance = 3 then "Good"
when worklifebalance = 4 then "Excellent"
else "No Change"
end as workLifeBal, count(hr_2.WorkLifeBalance) employee_count
from hr_1 inner join hr_2 on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by hr_1.JobRole, hr_2.WorkLifeBalance
order by hr_1.JobRole;

 
 #kpi 6
 # Attrition rate Vs Year since last promotion relation
 select case 
when yearssincelastpromotion >=0 and yearssincelastpromotion <=10 then "0-10"
when yearssincelastpromotion >=11 and yearssincelastpromotion <=20 then "11-20"
when yearssincelastpromotion >=21 and yearssincelastpromotion <=30 then "21-30"
when yearssincelastpromotion >=31 and yearssincelastpromotion <=40 then "31-40"
else "No Change"
end as LastPromotionYr_Group, concat(round(count(hr_1.attrition)/(select avg(hr_1.employeenumber))*100,2)," %") 
as "Attrition Rate"  from hr_1 join hr_2
on hr_1.EmployeeNumber=hr_2.`Employee ID`
where hr_1.attrition="yes"
group by LastPromotionYr_Group
order by LastPromotionYr_Group; 
