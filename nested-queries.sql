--This query displays the total count of restaurants by state that are open, have more than 300 reviews, and
-- have star ratings of above average
select state, count(state) as restaurant_count
from `inner-chassis-230421.Yelp_Dataset.Yelp_Business`
where is_open = 1 and review_count > 300 and stars >
(select avg(stars)
from `inner-chassis-230421.Yelp_Dataset.Yelp_Business`)
group by state
order by state

--This query displays the information of users who wrote more than 1000 reviews, have more than 500 'useful' votes,
--and have star ratings greater than average
select user_id, name, review_count, yelping_since, useful, average_stars
from Yelp_Dataset.Yelp_User
where review_count > 1000 and useful > 500 and average_stars >
(select avg(average_stars)
from Yelp_Dataset.Yelp_User)

--This query displays the information of businesses which received more than 100 'useful' votes on reviews
--and have reviews that received star ratings greater than average.
select yb.business_id, yb.name, yb.city, yb.state, yb.stars, yb.review_count
from Yelp_Dataset.Yelp_Business yb
inner join Yelp_Dataset.Yelp_Review yr on yb.business_id = yr.business_id
where yr.useful > 100 and yr.stars > (select avg(stars) from Yelp_Dataset.Yelp_Review)

--This query displays the number of businesses in each star rating (1-5). This query specifically shows businesses
--that received reviews from users who have written more than 1000 reviews and have more than 1000 fans.
select stars, count(business_id) as business_count
from `inner-chassis-230421.Yelp_Dataset.Yelp_Review`
where user_id in 
(select yr.user_id from `inner-chassis-230421.Yelp_Dataset.Yelp_Review` yr
inner join `inner-chassis-230421.Yelp_Dataset.Yelp_User` yu on yr.user_id = yu.user_id
where yu.review_count > 1000 and yu.fans > 1000)
group by stars
order by stars

--This query will show the 10 businesses with the same name that have the most above average reviews
select b.name, count(b.business_id) as number_of_reviews_above_average
from Yelp_Dataset.Yelp_Review r join Yelp_Dataset.Yelp_Business b on r.business_id = b.business_id 
where r.stars >= (select avg(stars) from Yelp_Dataset.Yelp_Review)  
group by b.name
order by number_of_reviews_above_average desc\
LIMIT 10

--This query will show the 10 businesses with the same name that have the most below average reviews
select b.name, count(b.business_id) as number_of_reviews_below_average
from Yelp_Dataset.Yelp_Review r join Yelp_Dataset.Yelp_Business b on r.business_id = b.business_id 
where r.stars <= (select avg(stars) from Yelp_Dataset.Yelp_Review)  
group by b.name
order by number_of_reviews_below_average desc
LIMIT 10

--This query will show the number of businesses per state that have a review count that is greater than the average
select state, count(state) as number_of_businesses
from Yelp_Dataset.Yelp_Business b
where b.business_id in (select c.business_id from Yelp_Dataset.Yelp_Business c where c.review_count >= (select avg(review_count) from Yelp_Dataset.Yelp_Business))
group by state 
order by number_of_businesses desc
LIMIT 10
                                                                                                        
--This query will show the number of businesses per state that have a review count that is lower than the average
select state, count(state) as number_of_businesses
from Yelp_Dataset.Yelp_Business b
where b.business_id in (select c.business_id from Yelp_Dataset.Yelp_Business c where c.review_count <= (select avg(review_count) from Yelp_Dataset.Yelp_Business))
group by state 
order by number_of_businesses desc
LIMIT 10                                                                                                 
                                                                                                        
--This query will show the number of businesses per state that have a review count that is greater than the average
select state, count(state) as number_of_businesses
from Yelp_Dataset.Yelp_Business b
where b.business_id in (select c.business_id from Yelp_Dataset.Yelp_Business c where c.review_count < (select avg(review_count) from Yelp_Dataset.Yelp_Business))
group by state 
order by number_of_businesses desc
LIMIT 10
                                                                                                       
--This query will show the difference in avg rating between the stores which have greater than average reviews and whether
--they are open or closed
select is_open, avg(r.stars) as avg_rating
from Yelp_Dataset.Yelp_Business b join Yelp_Dataset.Yelp_Review r on b.business_id = r.business_id
where b.business_id in (select c.business_id from Yelp_Dataset.Yelp_Business c where c.review_count < (select avg(review_count) from Yelp_Dataset.Yelp_Business))
group by b.is_open
                                                                                                       
                                                                                                       
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
